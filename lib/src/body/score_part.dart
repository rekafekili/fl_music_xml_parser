import 'package:fl_music_xml_parser/src/data/beam_value.dart';
import 'package:fl_music_xml_parser/src/data/note_type.dart';
import 'package:fl_music_xml_parser/src/data/stem_value.dart';
import 'package:xml/xml.dart';

class ScorePart {
  List<Part> partList = [];

  ScorePart(List<XmlNode> nodeList) {
    for (var node in nodeList) {
      partList.add(Part(node));
    }
  }
}

class Part {
  String? id;
  List<Measure> measures = [];

  Part(XmlNode node) {
    id = node.getAttribute('id');
    for (var node in node.findElements('measure')) {
      measures.add(Measure(node));
    }
  }
}

class Measure {
  String? id;
  int number = 0;
  bool implicit = false;
  bool nonControlling = false;
  String? text;
  double width = 0.0;
  List<MeasureObjects> objects = [];

  Measure(XmlElement element) {
    id = element.getAttribute('id');
    number = int.parse(element.getAttribute('number') ?? '0');
    implicit = bool.parse(element.getAttribute('implicit') ?? 'false');
    nonControlling =
        bool.parse(element.getAttribute('non-controlling') ?? 'false');
    text = element.getAttribute('text');
    width = double.parse(element.getAttribute('width') ?? '0.0');

    for (var el in element.childElements) {
      if (el.name.local == 'attributes') {
        objects.add(Attributes(el));
      } else if (el.name.local == 'note') {
        objects.add(Note(el));
      }
    }
  }
}

enum MeasureObjectsType { attributes, note }

abstract class MeasureObjects {
  MeasureObjectsType? type;
}

class Attributes extends MeasureObjects {
  int divisions = 0;
  int keyFifths = 0;
  String keyMode = '';
  int timeBeats = 0;
  int timeBeatType = 0;
  String clefSign = '';
  int clefLine = 0;

  Attributes(XmlElement element) {
    divisions = int.parse(element.getElement('divisions')?.innerText ?? '0');

    final keyElement = element.getElement('key');
    if (keyElement != null) {
      keyFifths = int.parse(keyElement.getElement('fifths')?.innerText ?? '0');
      keyMode = keyElement.getElement('mode')?.innerText ?? '';
    }

    final timeElement = element.getElement('time');
    if (timeElement != null) {
      timeBeats = int.parse(timeElement.getElement('beats')?.innerText ?? '0');
      timeBeatType =
          int.parse(timeElement.getElement('beat-type')?.innerText ?? '0');
    }

    final clefElement = element.getElement('clef');
    if (clefElement != null) {
      clefSign = clefElement.getElement('sign')?.innerText ?? '';
      clefLine = int.parse(clefElement.getElement('line')?.innerText ?? '0');
    }
  }
}

class Note extends MeasureObjects {
  int defaultX = 0;
  String pitch = '';
  int duration = 0;
  int voice = 0;
  NoteType noteType = NoteType.none;
  StemValue stemValue = StemValue.none;
  BeamValue beamValue = BeamValue.none;

  Note(XmlElement element) {
    defaultX = int.parse(element.getAttribute('default-x') ?? '0');

    final pitchElement = element.getElement('pitch');
    if (pitchElement != null) {
      pitch = pitchElement.getElement('step')?.innerText ?? '';
      pitch += pitchElement.getElement('octave')?.innerText ?? '';
    }

    duration = int.parse(element.getElement('duration')?.innerText ?? '0');
    voice = int.parse(element.getElement('voice')?.innerText ?? '0');
    noteType = NoteType.fromString(element.getElement('type')?.innerText ?? '');
    stemValue = StemValue.values
        .byName(element.getElement('stem')?.innerText ?? 'none');
    beamValue =
        BeamValue.fromString(element.getElement('beam')?.innerText ?? 'none');
  }
}
