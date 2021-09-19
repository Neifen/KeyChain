import 'package:flutter/material.dart';
import 'package:key_chain/keychain/db/key_saver.dart';

import 'key_entity.dart';

class KeyCard extends StatelessWidget {
  final KeyEntity _key;

  KeyCard(this._key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_key.content),
      background: Container(
        color: Colors.red,
        child: Text(
          "swipe to delete",
          style: TextStyle(color: Colors.white),
        ),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        KeySaver().deleteKey(this._key);
      },
      child: Card(
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_key.content),
                const Icon(Icons.radio_button_off)
              ],
            ),
          )),
    );
  }
}
