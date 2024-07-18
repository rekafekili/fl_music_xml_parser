import 'package:xml/xml.dart';

class ScoreDefaults {
  double scalingMillimeters = 0.0;
  int scalingTenths = 0;
  ScorePageLayout? pageLayout;
  ScoreSystemLayout? systemLayout;
  ScoreAppearance? appearance;
  ScoreMusicFont? musicFont;
  ScoreWordFont? wordFont;
  ScoreLyricFont? lyricFont;
  ScoreLyricLanguage? lyricLanguage;

  ScoreDefaults(XmlNode element) {
    final scaling = element.getElement('scaling');
    scalingMillimeters =
        double.tryParse(scaling?.getElement('millimeters')?.innerText ?? '') ??
            0.0;
    scalingTenths =
        int.tryParse(scaling?.getElement('tenths')?.innerText ?? '') ?? 0;

    pageLayout = ScorePageLayout(element.getElement('page-layout'));
    systemLayout = ScoreSystemLayout(element.getElement('system-layout'));
    appearance = ScoreAppearance(element.getElement('appearance'));

    _initDefaultFonts(element);
  }

  void _initDefaultFonts(XmlNode element) {
    if (element.getElement('music-font') != null) {
      musicFont = ScoreMusicFont();
      musicFont?.fontFamily =
          element.getElement('music-font')?.getAttribute('font-family');
      musicFont?.fontSize =
          element.getElement('music-font')?.getAttribute('font-size');
      musicFont?.fontStyle =
          element.getElement('music-font')?.getAttribute('font-style');
      musicFont?.fontWeight =
          element.getElement('music-font')?.getAttribute('font-weight');
    }

    if (element.getElement('word-font') != null) {
      wordFont = ScoreWordFont();
      wordFont?.fontFamily =
          element.getElement('word-font')?.getAttribute('font-family');
      wordFont?.fontSize =
          element.getElement('word-font')?.getAttribute('font-size');
      wordFont?.fontStyle =
          element.getElement('word-font')?.getAttribute('font-style');
      wordFont?.fontWeight =
          element.getElement('word-font')?.getAttribute('font-weight');
    }

    if (element.getElement('lyric-font') != null) {
      lyricFont = ScoreLyricFont();
      lyricFont?.fontFamily =
          element.getElement('lyric-font')?.getAttribute('font-family');
      lyricFont?.fontSize =
          element.getElement('lyric-font')?.getAttribute('font-size');
      lyricFont?.fontStyle =
          element.getElement('lyric-font')?.getAttribute('font-style');
      lyricFont?.fontWeight =
          element.getElement('lyric-font')?.getAttribute('font-weight');
      lyricFont?.name = element.getElement('lyric-font')?.getAttribute('name');
      lyricFont?.number =
          element.getElement('lyric-font')?.getAttribute('number');
    }

    if (element.getElement('lyric-language') != null) {
      lyricLanguage = ScoreLyricLanguage();
      lyricLanguage?.xmlLang =
          element.getElement('lyric-language')?.getAttribute('xml:lang');
      lyricLanguage?.name =
          element.getElement('lyric-language')?.getAttribute('name');
      lyricLanguage?.number =
          element.getElement('lyric-language')?.getAttribute('number');
    }
  }
}

class ScoreLyricLanguage {
  String? xmlLang;
  String? name;
  String? number;
}

class ScoreLyricFont extends ScoreFont {
  String? name;
  String? number;
}

class ScoreWordFont extends ScoreFont {}

class ScoreMusicFont extends ScoreFont {}

class ScoreFont {
  String? fontFamily;
  String? fontSize;
  String? fontStyle;
  String? fontWeight;

  double get fontSizeDouble => double.tryParse(fontSize ?? '') ?? 0.0;
}

class ScoreAppearance {
  ScoreLineWidth? lineWidth;
  ScoreNoteSize? noteSize;
  ScoreDistance? distance;

  ScoreAppearance(XmlElement? element) {
    if (element == null) return;

    if (element.getElement('line-width') != null) {
      _initLineWidth(element);
    }

    if (element.getElement('note-size') != null) {
      _initNoteSize(element);
    }

    if (element.getElement('distance') != null) {
      _initDistance(element);
    }
  }

  void _initDistance(XmlElement element) {
    distance = ScoreDistance();
    element.findElements('distance').forEach((element) {
      final type = element.getAttribute('type');
      switch (type) {
        case 'beam':
          distance?.beam = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'hyphen':
          distance?.hyphen = double.tryParse(element.innerText) ?? 0.0;
          break;
      }
    });
  }

  void _initNoteSize(XmlElement element) {
    noteSize = ScoreNoteSize();
    element.findElements('note-size').forEach((element) {
      final type = element.getAttribute('type');
      switch (type) {
        case 'cue':
          noteSize?.cue = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'grace':
          noteSize?.grace = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'grace-cue':
          noteSize?.graceCue = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'large':
          noteSize?.large = double.tryParse(element.innerText) ?? 0.0;
          break;
      }
    });
  }

  void _initLineWidth(XmlElement element) {
    lineWidth = ScoreLineWidth();
    element.findElements('line-width').forEach((element) {
      final type = element.getAttribute('type');
      switch (type) {
        case 'beam':
          lineWidth?.beam = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'bracket':
          lineWidth?.bracket = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'dashes':
          lineWidth?.dashes = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'enclosure':
          lineWidth?.enclosure = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'ending':
          lineWidth?.ending = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'extend':
          lineWidth?.extend = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'heavy barline':
          lineWidth?.heavyBarline = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'leger':
          lineWidth?.leger = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'light barline':
          lineWidth?.lightBarline = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'octave shift':
          lineWidth?.octaveShift = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'pedal':
          lineWidth?.pedal = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'slur middle':
          lineWidth?.slurMiddle = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'slur tip':
          lineWidth?.slurTip = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'staff':
          lineWidth?.staff = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'stem':
          lineWidth?.stem = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'tie middle':
          lineWidth?.tieMiddle = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'tie tip':
          lineWidth?.tieTip = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'tuplet bracket':
          lineWidth?.tupletBracket = double.tryParse(element.innerText) ?? 0.0;
          break;
        case 'wedge':
          lineWidth?.wedge = double.tryParse(element.innerText) ?? 0.0;
          break;
      }
    });
  }
}

class ScoreDistance {
  double beam = 0.0;
  double hyphen = 0.0;
}

class ScoreNoteSize {
  double cue = 0.0;
  double grace = 0.0;
  double graceCue = 0.0;
  double large = 0.0;
}

class ScoreLineWidth {
  double beam = 0.0;
  double bracket = 0.0;
  double dashes = 0.0;
  double enclosure = 0.0;
  double ending = 0.0;
  double extend = 0.0;
  double heavyBarline = 0.0;
  double leger = 0.0;
  double lightBarline = 0.0;
  double octaveShift = 0.0;
  double pedal = 0.0;
  double slurMiddle = 0.0;
  double slurTip = 0.0;
  double staff = 0.0;
  double stem = 0.0;
  double tieMiddle = 0.0;
  double tieTip = 0.0;
  double tupletBracket = 0.0;
  double wedge = 0.0;
}

class ScoreSystemLayout {
  double systemLeftMargin = 0.0;
  double systemRightMargin = 0.0;
  double systemDistance = 0.0;
  double topSystemDistance = 0.0;

  ScoreSystemLayout(XmlElement? element) {
    if (element == null) return;

    final systemMargins = element.getElement('system-margins');
    systemLeftMargin = double.tryParse(
            systemMargins?.getElement('left-margin')?.innerText ?? '') ??
        0.0;
    systemRightMargin = double.tryParse(
            systemMargins?.getElement('right-margin')?.innerText ?? '') ??
        0.0;

    systemDistance = double.tryParse(
            element.getElement('system-distance')?.innerText ?? '') ??
        0.0;
    topSystemDistance = double.tryParse(
            element.getElement('top-system-distance')?.innerText ?? '') ??
        0.0;
  }
}

class ScorePageLayout {
  int pageWidth = 0;
  int pageHeight = 0;
  List<PageMargins> pageMargins = [];

  ScorePageLayout(XmlElement? element) {
    if (element == null) return;

    pageWidth =
        int.tryParse(element.getElement('page-width')?.innerText ?? '0') ?? 0;
    pageHeight =
        int.tryParse(element.getElement('page-height')?.innerText ?? '0') ?? 0;

    _initPageMargins(element);
  }

  void _initPageMargins(XmlElement element) {
    element.findElements('page-margins').forEach((element) {
      final marginType =
          PageMarginType.values.byName(element.getAttribute('type') ?? 'both');
      final leftMargin =
          int.tryParse(element.getElement('left-margin')?.innerText ?? '') ?? 0;
      final rightMargin =
          int.tryParse(element.getElement('right-margin')?.innerText ?? '') ??
              0;
      final topMargin =
          int.tryParse(element.getElement('top-margin')?.innerText ?? '') ?? 0;
      final bottomMargin =
          int.tryParse(element.getElement('bottom-margin')?.innerText ?? '') ??
              0;

      pageMargins.add(PageMargins(
          marginType, leftMargin, rightMargin, topMargin, bottomMargin));
    });
  }
}

class PageMargins {
  PageMarginType? type;
  int left = 0;
  int right = 0;
  int top = 0;
  int bottom = 0;

  PageMargins(this.type, this.left, this.right, this.top, this.bottom);
}

enum PageMarginType {
  both,
  odd,
  even,
}
