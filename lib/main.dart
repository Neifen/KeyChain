import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:key_chain/app_constrains/register_things.dart';
import 'package:key_chain/contact/contact_page.dart';
import 'package:key_chain/gospel_track/gospel_track_page.dart';
import 'package:key_chain/gospel_track/page_number.dart';
import 'package:key_chain/keychain/keychain_page.dart';
import 'package:key_chain/login/loginData.dart';
import 'package:key_chain/login/loginPage.dart';
import 'package:key_chain/login/registerPage.dart';
import 'package:provider/provider.dart';
import 'key_maker/key_maker_page.dart';
import 'keychain/key_reciever.dart';
import 'keychain/key_states.dart';

void main() {
  RegisterThings().registerNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeyStates()),
        ChangeNotifierProvider(create: (_) => LoginData()),
        ChangeNotifierProvider(create: (_) => KeyReciever()),
        ChangeNotifierProvider(create: (_) => PageNumber())
      ],
      child: MaterialApp(
        title: 'Keys for life',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        routes: {
          KeyChainPage.route: (context) => KeyChainPage(),
          KeyMakerPage.route: (context) => KeyMakerPage(),
          LoginPage.route: (context) => LoginPage(),
          RegisterPage.route: (context) => RegisterPage(),
          ContactPage.route: (context) => ContactPage(),
          GospelTrackPage.route: (context) => GospelTrackPage(),
        },
        initialRoute: KeyChainPage.route,
      ),
    );
  }
}
