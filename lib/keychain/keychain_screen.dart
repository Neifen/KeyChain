import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/keychain/key_reciever.dart';
import 'package:key_chain/login/authProvider.dart';
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
          child: Consumer<KeyReciever>(
            builder: (_, keySaver, __) {
              return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: keySaver.keyList.length,
                  itemBuilder: (_, index) => KeyCard(keySaver.keyList[index]));
            },
          ),
        )
      ],
    );
  }
}
