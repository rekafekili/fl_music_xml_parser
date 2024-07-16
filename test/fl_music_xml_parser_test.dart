import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fl_music_xml_parser/fl_music_xml_parser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MusicXmlParser mxlDocument = MusicXmlParser('assets/Saltarello.musicxml');

  test('\'assets/Saltarello.musicxml\' Parsing Test', () {
    final doc = mxlDocument.scoreXml;

    expect(doc.isScorePartwise, true);
    expect(doc.movementTitle, 'Saltarello');
    expect(doc.identification?.composer, 'Anonymous');
    expect(doc.identification?.rights, 'Copyright © 2010 MakeMusic, Inc.');
    expect(doc.identification?.encoding?.software, 'Finale v27.0 for Mac');
    expect(doc.identification?.encoding?.encodingDate, '2021-06-04');
  });
}
