import 'package:fl_music_xml_parser/fl_music_xml_parser.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Viewer extends StatefulWidget {
  const Viewer({
    super.key,
    required this.exampleAssetPath,
    required this.xmlAssetPath,
  });

  final String? exampleAssetPath;
  final String xmlAssetPath;

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  String folder = 'assets';
  PdfControllerPinch? pdfPinchController;
  ScoreXml? scoreXml;

  @override
  void initState() {
    super.initState();
    folder = widget.exampleAssetPath != null
        ? widget.exampleAssetPath!.split('.').elementAt(0)
        : 'assets';

    if (widget.exampleAssetPath != null &&
        widget.exampleAssetPath!.endsWith('.pdf')) {
      pdfPinchController = PdfControllerPinch(
          document: PdfDocument.openAsset(
              'assets/$folder/${widget.exampleAssetPath!}'));
    }

    MusicXmlParser.loadFromXmlFile('assets/$folder/${widget.xmlAssetPath}')
        .then((value) {
      setState(() => scoreXml = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final exampleView = widget.exampleAssetPath != null
        ? (widget.exampleAssetPath!.endsWith('.pdf')
            ? PdfViewPinch(controller: pdfPinchController!)
            : Image.asset('assets/$folder/${widget.exampleAssetPath!}'))
        : const SizedBox.shrink();

    return Material(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(child: exampleView),
            const _Divider(),
            Flexible(
              child: ScoreXmlText(
                xml: scoreXml,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreXmlText extends StatelessWidget {
  const ScoreXmlText({
    super.key,
    required this.xml,
  });

  final ScoreXml? xml;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TitleAndDescRow(
                  title: 'Movement Title',
                  desc: '${xml?.movementTitle}',
                ),
                TitleAndDescRow(
                  title: 'Composer',
                  desc: '${xml?.identification?.composer}',
                ),
                TitleAndDescRow(
                  title: 'Rights',
                  desc: '${xml?.identification?.rights}',
                ),
                TitleAndDescRow(
                  title: 'Software',
                  desc: '${xml?.identification?.encoding?.software}',
                ),
                TitleAndDescRow(
                  title: 'Encoding Date',
                  desc: '${xml?.identification?.encoding?.encodingDate}',
                ),
                TitleAndDescRow(
                  title: 'Score Parts',
                  desc:
                      '${xml?.partList?.scoreParts.map((e) => '${e.id}: ${e.partName}').join(', ')}',
                ),
                for (Part part in xml?.part?.partList ?? [])
                  ExpansionTile(
                    title: TitleAndDescRow(
                      title: 'Part: ',
                      desc: '${part.id} / ${part.measures.length} measures',
                    ),
                    children: [
                      for (Measure measure in part.measures)
                        ListTile(
                          title: Text(
                            'Measure: ${measure.number}',
                          ),
                          subtitle: Text(
                            measure.objects.map((element) {
                              if (element is Attributes) {
                                return '${element.keyFifths}/${element.keyMode}//${element.timeBeats}/${element.timeBeatType}//${element.clefSign}/${element.clefLine}';
                              } else if (element is Note) {
                                return '${element.pitch}/${element.duration}/${element.stemValue}/${element.beamValue}';
                              }
                            }).join('\n'),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        const _Divider(),
        Flexible(
          child: SingleChildScrollView(
            child: Text(
              '${xml?.toString()}',
            ),
          ),
        ),
      ],
    );
  }
}

class TitleAndDescRow extends Row {
  TitleAndDescRow({
    super.key,
    required String title,
    required String desc,
  }) : super(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                desc,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
}

class _Divider extends Divider {
  const _Divider()
      : super(
          thickness: 2,
          height: 32,
          color: Colors.red,
        );
}
