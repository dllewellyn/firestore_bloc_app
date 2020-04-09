import 'package:firestoreblocapp/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FullNoteScreen extends StatelessWidget {
  final Tip tip;

  const FullNoteScreen({Key key, @required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tip.tipName),
      ),
      body: Container(
          padding: const EdgeInsets.all(16), child: Text(tip.fullTipText)),
    );
  }
}
