import 'package:xml/xml.dart';

class ScorePartList {
  List<PartListScorePart> scoreParts = [];

  ScorePartList(XmlNode element) {
    for (var element in element.childElements) {
      if (element.name.local == 'score-part') {
        scoreParts.add(PartListScorePart(element));
      }
    }
  }
}

class PartListScorePart {
  String? id;
  String? partName;
  PartListScoreInstrument? instrument;
  PartListMidiInstrument? midiInstrument;

  PartListScorePart(XmlElement element) {
    id = element.getAttribute('id');
    partName = element.getElement('part-name')?.innerText;
    instrument =
        PartListScoreInstrument(element.getElement('score-instrument'));
    midiInstrument =
        PartListMidiInstrument(element.getElement('midi-instrument'));
  }
}

class PartListMidiInstrument {
  String? id;
  String? midiChannel;
  String? midiProgram;
  String? midiName;
  String? volume;
  String? pan;

  PartListMidiInstrument(XmlElement? element) {
    if (element == null) return;

    id = element.getAttribute('id');
    midiChannel = element.getElement('midi-channel')?.innerText;
    midiProgram = element.getElement('midi-program')?.innerText;
    midiName = element.getElement('midi-name')?.innerText;
    volume = element.getElement('volume')?.innerText;
    pan = element.getElement('pan')?.innerText;
  }
}

class PartListScoreInstrument {
  String? id;
  String? instrumentName;
  String? instrumentAbbreviation;
  String? instrumentSound;

  PartListScoreInstrument(XmlElement? element) {
    if (element == null) return;

    id = element.getAttribute('id');
    instrumentName = element.getElement('instrument-name')?.innerText;
    instrumentAbbreviation =
        element.getElement('instrument-abbreviation')?.innerText;
    instrumentSound = element.getElement('instrument-sound')?.innerText;
  }
}
