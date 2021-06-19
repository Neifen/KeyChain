import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:key_chain/keychain/key_states.dart';
import 'package:provider/provider.dart';

import 'my_drawer.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  MyScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(),
        appBar: AppBar(
          //title: Text("Keychain"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(CupertinoIcons.bars),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: body);
  }
}
