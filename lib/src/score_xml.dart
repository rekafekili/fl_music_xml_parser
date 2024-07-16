import 'package:fl_music_xml_parser/src/header/score_identification.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

class ScoreXml {
  String? movementTitle;
  bool isScorePartwise = false;
  ScoreIdentification? identification;

  ScoreXml(XmlDocument xmlDocument) {
    isScorePartwise = (xmlDocument.rootElement.name.local == 'score-partwise');

    movementTitle =
        xmlDocument.xpath('/score-partwise/movement-title').first.innerText;

    final nodeIdentification =
        xmlDocument.xpath('/score-partwise/identification').first;
    identification = ScoreIdentification(nodeIdentification);
  }
}
