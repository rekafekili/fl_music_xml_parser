library fl_music_xml_parser;

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
