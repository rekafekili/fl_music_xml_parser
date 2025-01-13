import 'package:flutter/material.dart';

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
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            Text(exampleAssetPath ?? ''),
            Text(xmlAssetPath),
          ],
        ),
      ),
    );
  }
}
