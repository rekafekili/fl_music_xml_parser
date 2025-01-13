import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Viewer extends StatelessWidget {
  const Viewer({
    super.key,
    required this.exampleAssetPath,
    required this.xmlAssetPath,
  });

  final String? exampleAssetPath;
  final String xmlAssetPath;

  @override
  Widget build(BuildContext context) {
    final folder = exampleAssetPath != null
        ? exampleAssetPath!.split('.').elementAt(0)
        : 'assets';
    final PdfControllerPinch pdfPinchController = PdfControllerPinch(
        document: PdfDocument.openAsset('assets/$folder/${exampleAssetPath!}'));

    final exampleView = exampleAssetPath != null
        ? (exampleAssetPath!.endsWith('.pdf')
            ? PdfViewPinch(controller: pdfPinchController)
            : Image.asset('assets/$folder/${exampleAssetPath!}'))
        : const SizedBox.shrink();

    return Material(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(child: exampleView),
            const Divider(
              thickness: 2,
              height: 32,
              color: Colors.red,
            ),
            Flexible(child: Text(xmlAssetPath)),
          ],
        ),
      ),
    );
  }
}
