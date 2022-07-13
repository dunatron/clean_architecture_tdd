import 'dart:io';

import 'package:clean_architecture_tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import './injectionContainer.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = (await getApplicationDocumentsDirectory()).path;

  Hive.init(path);
  // Hive.registerAdapter(NoteEntityAdapter());
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
