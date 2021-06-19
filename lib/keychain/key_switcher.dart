import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'key_states.dart';

class KeySwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KeyStates _keyStates = Provider.of<KeyStates>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Do you want to receive Keys?'),
          Switch(
            value: _keyStates.receiveKeys,
            onChanged: (bool newValue) {
              _keyStates.switchKey();
            },
          )
        ],
      ),
    );
  }
}
