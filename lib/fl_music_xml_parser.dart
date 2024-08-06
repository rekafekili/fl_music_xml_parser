library fl_music_xml_parser;

export 'src/data/note_type.dart';
export 'src/data/stem_value.dart';
export 'src/data/beam_value.dart';
export 'src/body/score_part.dart';
export 'src/header/score_defaults.dart';
export 'src/header/score_identification.dart';
export 'src/header/score_part_list.dart';
export 'src/score_xml.dart';

import 'package:fl_music_xml_parser/src/score_xml.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class MusicXmlParser {
  late ScoreXml scoreXml;

  MusicXmlParser(String filePath) {
    loadMusicXmlFile(filePath);
  }

  Future<void> loadMusicXmlFile(String filePath) async {
    final xmlStr = await rootBundle.loadString(filePath);
    final document = XmlDocument.parse(xmlStr);
    scoreXml = ScoreXml(document);
  }
}
