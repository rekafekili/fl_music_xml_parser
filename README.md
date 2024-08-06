# fl_music_xml_parser

Welcome to the Flutter MusicXML Parser library! This library provides an easy and efficient way to parse MusicXML files into `ScoreXml` objects within your Flutter applications. MusicXML is a widely used format for representing musical scores, and with this library, you can seamlessly integrate music notation into your Flutter apps.

---

## Features

### Load File to MusicXmlParser

```
MusicXmlParser mxlDocument = MusicXmlParser('assets/Saltarello.musicxml');
ScoreXml scoreXml = mxlDocument.scoreXml;
```

### ScoreXml has data of MusicXML

#### Movement Title

```
scoreXml.movementTitle;
```

#### Identification

```
// Composer
scoreXml.identification?.composer;

// Rights
scoreXml.identification?.rights;

// Encoding - Software, EncodingDate
scoreXml.identification?.encoding?.software;
scoreXml.identification?.encoding?.encodingDate;
```

#### Defaults

```
// PageLayout
scoreXml.defaults?.pageLayout?.pageHeight;
scoreXml.defaults?.pageLayout?.pageWidth;

// SystemLayout
scoreXml.defaults?.systemLayout?.systemDistance;
scoreXml.defaults?.systemLayout?.topSystemDistance;

// Appearance
scoreXml.defaults?.appearance?.lineWidth?.stem;
scoreXml.defaults?.appearance?.lineWidth?.beam;
scoreXml.defaults?.appearance?.lineWidth?.staff;
scoreXml.defaults?.appearance?.lineWidth?.lightBarline;
scoreXml.defaults?.appearance?.lineWidth?.heavyBarline;
scoreXml.defaults?.appearance?.distance?.beam, 7.5;
scoreXml.defaults?.appearance?.distance?.hyphen, 60;
...

// Fonts
scoreXml.defaults?.musicFont?.fontFamily;
scoreXml.defaults?.musicFont?.fontSize;
scoreXml.defaults?.musicFont?.fontSizeDouble;
scoreXml.defaults?.wordFont?.fontFamily;
scoreXml.defaults?.wordFont?.fontSize;
scoreXml.defaults?.wordFont?.fontSizeDouble;
```

#### Part List

```
// Score Part
scoreXml.partList?.scoreParts[0].id;
scoreXml.partList?.scoreParts[0].partName;
scoreXml.partList?.scoreParts[0].instrument?.id;
...

// Score Part - Midi Instrument
scoreXml.partList?.scoreParts[0].midiInstrument?.id;
scoreXml.partList?.scoreParts[0].midiInstrument?.midiChannel;
scoreXml.partList?.scoreParts[0].midiInstrument?.midiProgram;
scoreXml.partList?.scoreParts[0].midiInstrument?.volume;
scoreXml.partList?.scoreParts[0].midiInstrument?.pan;
...
```

#### Part

```
scoreXml.part?.partList.length;
scoreXml.part?.partList[0].id;
scoreXml.part?.partList[0].measures.length;
scoreXml.part?.partList[0].measures[0].objects.length;
scoreXml.part?.partList[0].measures.forEach((measure) {
    for (var element in measure.objects) {
        if (element is Attributes) {
            print(
                '${element.keyFifths}/${element.keyMode}//${element.timeBeats}/${element.timeBeatType}//${element.clefSign}/${element.clefLine}');
        } else if (element is Note) {
            print(
                '${element.pitch}/${element.duration}/${element.stemValue}/${element.beamValue}');
        }
    }
    print('--------------------------------');
});
```

---

## To Do List

- Parse Notations
- Parse Lyrics
- Parse Chord
- Parse BarLine
- Enable to Load `.mxl` file

---

## MusicXML Test List

1. Telemann.musicxml
2. SchbAvMaSample.musicxml
3. Saltarello.musicxml : **Passed**
4. MozaVeilSample.musicxml
5. MozartTrio.musicxml
6. MozartPianoSonata.musicxml
7. MozaChloSample.musicxml
8. MahlFaGe4Sample.musicxml
9. FaurReveSample.musicxml
10. Echigo-Jishi.musicxml
11. Dichterliebe01.musicxml
12. DebuMandSample.musicxml
13. Chant.musicxml
14. BrookeWestSample.musicxml
15. BrahWiMeSample.musicxml
16. Binchois.musicxml
17. BeetAnGeSample.musicxml
18. ActorPreludeSample.musicxml

---

## Development Approach

I believe in developing this library incrementally to ensure robustness and reliability. Starting with the sample files provided on the official MusicXML website, we test and enhance the parser to handle a wide variety of MusicXML elements and attributes. This approach allows us to deliver a stable and comprehensive solution that evolves with each iteration, catering to the diverse needs of music notation applications.
