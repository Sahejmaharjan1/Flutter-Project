import 'package:flutter/material.dart';

import '../components/choose-language.dart';
import '../components/translate-text.dart';
import 'result.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _firstLanguage = "af";
  String _secondLanguage = "af";
  String _result = '';
  void _firstlanguagecodefunction(String firstlanguagecode) {
    // var aBool = true;
    // aBool = false;
    setState(() {
      _firstLanguage = firstlanguagecode;
    });
  }

  void _secondlanguagecodefunction(String secondlanguagecode) {
    // var aBool = true;
    // aBool = false;
    setState(() {
      _secondLanguage = secondlanguagecode;
    });
  }

  void _resultfunction(String result) {
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: EdgeInsets.only(bottom: 8.0),
              child: TranslateText(
                  firstlanguage: _firstLanguage,
                  secondlanguage: _secondLanguage,
                  resultfunction: _resultfunction),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ChooseLanguage(
                  firstlanguage: _firstlanguagecodefunction,
                  secondlanguage: _secondlanguagecodefunction),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: EdgeInsets.only(bottom: 8.0),
              child: Result(result: _result),
            ),
          ],
        ),
      ),
    );
  }
}
