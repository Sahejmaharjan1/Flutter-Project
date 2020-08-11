import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

// import './choose-language.dart';
class Translator extends StatefulWidget {
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  GoogleTranslator translator =
      new GoogleTranslator(); //using google translator

  String out;
  final lang = TextEditingController(); //getting text

  void trans() {
    translator.translate(lang.text, to: 'hi') //translating to hi = hindi
        .then((output) {
      setState(() {
        out = output; //placing the translated text to the String to be used
      });
      print(out);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: <Widget>[
          TextField(
            controller: lang,
          ),
          RaisedButton(
            color: Colors.red,
            child: Text(
                "Press !!"), //on press to translate the language using function
            onPressed: () {
              trans();
            },
          ),
          Text(out.toString()) //translated string
        ],
      )),
    );
  }
}
