import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/keychain/key_saver.dart';
import 'package:provider/provider.dart';
import 'key_card.dart';
import 'key_switcher.dart';

class KeyChainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        KeySwitcher(),
        Expanded(
          //todo: problem, this only adds new keys whenever keysaver throws an event. let's add all the saved one
          child: Consumer<KeySaver>(
            builder: (_, keySaver, __) => ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: keySaver.keyList.length,
                itemBuilder: (_, index) => KeyCard(keySaver.keyList[index])),
          ),
        )
      ],
    );
  }
}
