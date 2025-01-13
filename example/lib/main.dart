import 'dart:convert';

import 'package:example/viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MusicXML Parser Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, List<String>> exampleDirectory = {};

  @override
  void initState() {
    super.initState();
    _loadExampleFiles();
  }

  Future<void> _loadExampleFiles() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final Map<String, List<String>> structure = {};

    for (String key in manifestMap.keys) {
      if (key.startsWith('assets/')) {
        final parts = key.split('/');
        if (parts.length > 2) {
          final folder = parts[1];
          final file = parts.sublist(2).join('/');
          if (!structure.containsKey(folder)) {
            structure[folder] = [];
          }
          structure[folder]!.add(file);
        }
      }
    }

    setState(() {
      exampleDirectory = structure;
    });
  }

  void onTapFile(String folder, String file) {
    if (file.endsWith('.pdf') ||
        file.endsWith('.png') ||
        file.endsWith('.mxl')) {
      return;
    }

    final exampleAssetPath = exampleDirectory[folder]?.firstWhere(
      (e) => e.endsWith('.png') || e.endsWith('pdf'),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Viewer(
          exampleAssetPath: exampleAssetPath,
          xmlAssetPath: file,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'NOW The Parser supports only .musicxml files : 2025.01.13',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: exampleDirectory.isEmpty
                ? const CircularProgressIndicator()
                : ListView(
                    children: exampleDirectory.entries.map(
                      (entry) {
                        return ExpansionTile(
                          title: Text(entry.key),
                          children: entry.value.map((file) {
                            return ListTile(
                              onTap: () => onTapFile(entry.key, file),
                              title: Text(file),
                            );
                          }).toList(),
                        );
                      },
                    ).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
