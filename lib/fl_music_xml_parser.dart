library fl_music_xml_parser;

import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class MxlDocument {
  String? title;

  Future<void> loadMusicXmlFile(String filePath) async {
    final xmlStr = await rootBundle.loadString(filePath);
    final document = XmlDocument.parse(xmlStr);
  }
}
