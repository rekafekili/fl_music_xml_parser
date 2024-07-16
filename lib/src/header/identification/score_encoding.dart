import 'package:xml/xml.dart';

class ScoreEncoding {
  String? software;
  String? encodingDate;

  ScoreEncoding(XmlNode nodeEncoding) {
    software = nodeEncoding.getElement('software')?.innerText;
    encodingDate = nodeEncoding.getElement('encoding-date')?.innerText;

    // TODO: Add more encoding properties. e.g. supports, supports attribute
  }
}
