import 'dart:io';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Gallary extends StatefulWidget {
  final String languagesecond;
  Gallary({@required this.languagesecond});
  @override
  _GallaryState createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {
  var out;

  // String<ChooseLanguage> _testing=ChooseLanguage.returnfirstcode();
  GoogleTranslator translator = new GoogleTranslator();
  //using google translator
  void trans() {
    // print(texttotranslate.text);
    translator
        .translate(texttotranslate.text,
            to: widget.languagesecond) //translating to hi = hindi
        .then((output) {
      print(output);
      setState(() {
        out = output; //placing the translated text to the String to be used
      });
      print(out);
    });
  }

  var texttotranslate = TextEditingController();
  File checking;
  File pickedImage;
  var readString = '';
  bool isImageLoaded = false;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      texttotranslate.text = '';
      out = '';
      checking = pickedImage;
      pickedImage = tempStore;
      if (pickedImage == null) {
        Navigator.of(context).pop();
      }
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    readString = '';
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          print(word.text);
          readString = readString + ' ' + '${word.text}';
        }
      }
    }
    print('result is');
    print(readString.toString());
    setState(() {
      texttotranslate.text = readString.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            isImageLoaded
                ? Center(
                    child: Container(
                        height: 350.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.cover))),
                  )
                : Container(),
            Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0, left: 85.0, right: 40.0, top: 20.0),
                    child: RaisedButton(
                      child: Text('Pick another image'),
                      onPressed: pickImage,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 20.0, right: 40.0, top: 20.0),
                    child: RaisedButton(
                      child: Text('Read Text'),
                      onPressed: readText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Text(
                texttotranslate.text,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              child: ButtonTheme(
                minWidth: 1.0,
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
            Card(
              color: Colors.white,
              margin: EdgeInsets.all(0.0),
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                height: 500.0,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    out == null
                        ? Text('')
                        : Text(
                            out,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20.0,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
