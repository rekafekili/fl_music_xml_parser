import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

class ScoreIdentification {
  // Creator
  String? composer;
  String? poet;
  String? lyricist;
  String? arranger;

  // Rights
  String? rights;
  String? source;

  // Encoding
  ScoreEncoding? encoding;

  ScoreIdentification(XmlNode nodeIdentification) {
    _initCreator(nodeIdentification);
    _initRights(nodeIdentification);
    _initEncoding(nodeIdentification);
  }

  void _initEncoding(XmlNode identification) {
    encoding = ScoreEncoding(identification.xpath('encoding').first);
  }

  void _initRights(XmlNode identification) {
    rights = identification.getElement('rights')?.innerText;
    source = identification.getElement('source')?.innerText;
  }

  void _initCreator(XmlNode identification) {
    identification.xpath('creator').forEach((xmlNode) {
      final type = xmlNode.getAttribute('type');
      switch (type) {
        case 'composer':
          composer = xmlNode.innerText;
          break;
        case 'poet':
          poet = xmlNode.innerText;
          break;
        case 'lyricist':
          lyricist = xmlNode.innerText;
          break;
        case 'arranger':
          arranger = xmlNode.innerText;
          break;
        default:
          composer = xmlNode.innerText;
      }
    });
  }
}

class ScoreEncoding {
  String? software;
  String? encodingDate;

  ScoreEncoding(XmlNode nodeEncoding) {
    software = nodeEncoding.getElement('software')?.innerText;
    encodingDate = nodeEncoding.getElement('encoding-date')?.innerText;

    // TODO: Add more encoding properties. e.g. supports, supports attribute
  }
}
