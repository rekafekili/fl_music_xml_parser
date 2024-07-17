import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

import 'header/score_defaults.dart';
import 'header/score_identification.dart';

class ScoreXml {
  String? movementTitle;
  bool isScorePartwise = false;
  ScoreIdentification? identification;
  ScoreDefaults? defaults;

  ScoreXml(XmlDocument xmlDocument) {
    isScorePartwise = (xmlDocument.rootElement.name.local == 'score-partwise');

    movementTitle =
        xmlDocument.xpath('/score-partwise/movement-title').first.innerText;

    final nodeIdentification =
        xmlDocument.xpath('/score-partwise/identification').first;
    identification = ScoreIdentification(nodeIdentification);

    final nodeDefaults = xmlDocument.xpath('/score-partwise/defaults').first;
    defaults = ScoreDefaults(nodeDefaults);

    xmlDocument.xpath('/score-partwise/part-list').first;
  }
}
