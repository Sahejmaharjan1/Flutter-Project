import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final String result;
  Result({@required this.result});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0.0),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        height: 150.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.result == null
                ? Text('')
                : Text(
                    widget.result,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20.0,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
