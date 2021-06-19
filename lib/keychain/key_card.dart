import 'package:flutter/material.dart';

class KeyCard extends StatelessWidget {
  final String _text;

  KeyCard(this._text);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(_text), const Icon(Icons.radio_button_off)],
          ),
        ));
  }
}
