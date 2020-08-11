import 'package:flutter/material.dart';

import 'screens/home-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.green[600],
      ),
      home: HomePage(title: 'Language Translate'),
    );
  }
}
