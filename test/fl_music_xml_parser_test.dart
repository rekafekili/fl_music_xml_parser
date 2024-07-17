import 'package:fl_music_xml_parser/src/header/score_defaults.dart';
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
    expect(doc.defaults?.scalingMillimeters, 5.0271);
    expect(doc.defaults?.scalingTenths, 40);
    expect(doc.defaults?.pageLayout?.pageHeight, 2223);
    expect(doc.defaults?.pageLayout?.pageWidth, 1718);
    expect(doc.defaults?.pageLayout?.pageMargins[0].type, PageMarginType.both);
    expect(doc.defaults?.pageLayout?.pageMargins[0].left, 101);
    expect(doc.defaults?.pageLayout?.pageMargins[0].right, 101);
    expect(doc.defaults?.pageLayout?.pageMargins[0].top, 126);
    expect(doc.defaults?.pageLayout?.pageMargins[0].bottom, 126);
    expect(doc.defaults?.systemLayout?.systemDistance, 115);
    expect(doc.defaults?.systemLayout?.topSystemDistance, 115);
    expect(doc.defaults?.appearance?.lineWidth?.stem, 0.957);
    expect(doc.defaults?.appearance?.lineWidth?.beam, 5);
    expect(doc.defaults?.appearance?.lineWidth?.staff, 1.25);
    expect(doc.defaults?.appearance?.lineWidth?.lightBarline, 1.4583);
    expect(doc.defaults?.appearance?.lineWidth?.heavyBarline, 5);
    expect(doc.defaults?.appearance?.lineWidth?.leger, 1.875);
    expect(doc.defaults?.appearance?.lineWidth?.ending, 1.4583);
    expect(doc.defaults?.appearance?.lineWidth?.wedge, 0.9375);
    expect(doc.defaults?.appearance?.lineWidth?.enclosure, 1.4583);
    expect(doc.defaults?.appearance?.lineWidth?.tupletBracket, 1.4583);
    expect(doc.defaults?.appearance?.lineWidth?.octaveShift, 0.0);
    expect(doc.defaults?.appearance?.noteSize?.grace, 50);
    expect(doc.defaults?.appearance?.noteSize?.cue, 50);
    expect(doc.defaults?.appearance?.noteSize?.large, 0);
    expect(doc.defaults?.appearance?.distance?.beam, 7.5);
    expect(doc.defaults?.appearance?.distance?.hyphen, 60);
  });
}
