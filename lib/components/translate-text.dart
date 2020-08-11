import 'package:flutter/material.dart';
import '../components/gallary.dart';
import 'package:translator/translator.dart';
import 'package:speech_recognition/speech_recognition.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../screens/meaning.dart';
import 'camera.dart';

// import './camera.dart';
class TranslateText extends StatefulWidget {
  final String firstlanguage;
  final String secondlanguage;
  final Function resultfunction;
  TranslateText(
      {@required this.firstlanguage,
      @required this.secondlanguage,
      @required this.resultfunction});
  @override
  _TranslateTextState createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() {
        resultText = speech;
        texttotranslate.text = resultText;
      }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  var texttotranslate = TextEditingController();
  // var reulttexttranslate=TextEditingController();
  //  reulttexttranslate=resultText;
  var out;
  // String<ChooseLanguage> _testing=ChooseLanguage.returnfirstcode();
  GoogleTranslator translator = new GoogleTranslator();
  //using google translator
  void trans() {
    // print(widget.codeoffirst);
    translator
        .translate(texttotranslate.text,
            from: widget.firstlanguage,
            to: widget.secondlanguage) //translating to hi = hindi
        .then((output) {
      setState(() {
        widget.resultfunction(output);
        out = output; //placing the translated text to the String to be used
      });
      print(out);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0.0),
      elevation: 2.0,
      child: Container(
        height: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: TextField(
                    controller: texttotranslate,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter text here to translate",
                    ),
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.camera_alt),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Camera(languagesecond: widget.secondlanguage)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FloatingActionButton(
                    heroTag: "btn5",
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.photo_album),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Gallary(languagesecond: widget.secondlanguage)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.library_books),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: out == null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Meaning(result: texttotranslate.text)),
                            );
                          },
                  ),
                ),
                // FloatingActionButton(
                //   child: Icon(Icons.cancel),
                //   mini: true,
                //   backgroundColor: Colors.deepOrange,
                //   onPressed: () {
                //     if (_isListening)
                //       _speechRecognition.cancel().then(
                //             (result) => setState(() {
                //                   _isListening = result;
                //                   resultText = "";
                //                 }),
                //           );
                //   },
                // ),
                FloatingActionButton(
                  child: Icon(Icons.mic),
                  heroTag: "btn3",
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.stop().then(
                            (result) => setState(() {
                              _isListening = result;
                            }),
                          );
                    if (_isAvailable && !_isListening)
                      _speechRecognition.listen(locale: "en_US").then((result) {
                        print('$result');
                      });
                  },
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                ),
                FloatingActionButton(
                  heroTag: "btn4",
                  child: Icon(Icons.stop),
                  mini: true,
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                      if (_isListening)
                      _speechRecognition.cancel().then(
                            (result) => setState(() {
                                  _isListening = result;
                                  resultText = "";
                                }),
                          );
                  },
                ),
                Padding(
                  child: ButtonTheme(
                    minWidth: 120.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text("Translate"),
                      onPressed: trans,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(16.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
