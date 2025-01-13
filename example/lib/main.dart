import 'dart:convert';

import 'package:fl_music_xml_parser/fl_music_xml_parser.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: exampleDirectory.isEmpty
            ? const CircularProgressIndicator()
            : ListView(
                children: exampleDirectory.entries.map(
                  (e) {
                    return ExpansionTile(
                      title: Text(e.key),
                      children: e.value.map((file) {
                        return ListTile(
                          title: Text(file),
                        );
                      }).toList(),
                    );
                  },
                ).toList(),
              ),
      ),
    );
  }
}
