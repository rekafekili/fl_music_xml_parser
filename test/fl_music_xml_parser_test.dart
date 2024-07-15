import 'package:flutter_test/flutter_test.dart';

import 'package:fl_music_xml_parser/fl_music_xml_parser.dart';

void main() {
  MxlDocument mxlDocument = MxlDocument();

  mxlDocument.loadMusicXmlFile('assets/test/Saltarello.musicxml');
}
