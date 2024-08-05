import 'package:fl_music_xml_parser/src/body/score_part.dart';
import 'package:fl_music_xml_parser/src/header/score_part_list.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

import 'header/score_defaults.dart';
import 'header/score_identification.dart';

class ScoreXml {
  String? movementTitle;
  bool isScorePartwise = false;

  ScoreIdentification? identification;
  ScoreDefaults? defaults;
  ScorePartList? partList;
  ScorePart? part;

  ScoreXml(XmlDocument xmlDocument) {
    isScorePartwise = (xmlDocument.rootElement.name.local == 'score-partwise');

    movementTitle =
        xmlDocument.xpath('/score-partwise/movement-title').first.innerText;

    final nodeIdentification =
        xmlDocument.xpath('/score-partwise/identification').first;
    identification = ScoreIdentification(nodeIdentification);

    final nodeDefaults = xmlDocument.xpath('/score-partwise/defaults').first;
    defaults = ScoreDefaults(nodeDefaults);

    final nodePartList = xmlDocument.xpath('/score-partwise/part-list').first;
    partList = ScorePartList(nodePartList);

    part = ScorePart(xmlDocument.xpath('score-partwise/part').toList());
  }
}
