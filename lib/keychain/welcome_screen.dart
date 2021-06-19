import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'key_switcher.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.headline4,
        ),
        KeySwitcher()
      ],
    );
  }
}
