import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Meaning extends StatefulWidget {
  final String result;
  Meaning({@required this.result});
  @override
  _MeaningState createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  @override
  void initState() {
    // print("trsdflkj");
    print(widget.result);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Browser"),
      ),
      url:
          "https://dictionary.cambridge.org/dictionary/english/${widget.result}",
    );
  }
}
