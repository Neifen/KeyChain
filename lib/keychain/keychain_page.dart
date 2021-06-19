import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:provider/provider.dart';

import 'key_states.dart';
import 'keychain_screen.dart';
import 'welcome_screen.dart';

class KeyChainPage extends StatelessWidget {
  static const String route = 'home';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Consumer<KeyStates>(builder: (_, keyStates, __) {
        if (keyStates.firstTime) {
          return WelcomeScreen();
        }
        return KeyChainScreen();
      }),
    );
  }
}
