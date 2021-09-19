import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:key_chain/keychain/db/key_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class KeyStates extends ChangeNotifier {
  static String prefName = 'receiveKeys';
  SharedPreferences? _sharedPreferences;
  StreamSubscription<RemoteMessage>? _firebaseMessagingSub;

  KeyStates() {
    //SharedPreferences preferences
    loadPreference();
  }

  bool receiveKeys = false, _firstTime = true;

  loadPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var savedPref = _sharedPreferences!.getBool(prefName);
    if (savedPref != null && savedPref) {
      receiveKeys = true;
      _firstTime = false;
      notifyListeners();
      listeningSetups();
    }
  }

  bool get firstTime => _firstTime;

  switchKey() async {
    receiveKeys = !receiveKeys;
    _firstTime = false;

    // when receveKeys is OFF and the list is EMPTY -> show welcome screen
    if (!receiveKeys && (await KeySaver().count()) == 0) {
      _firstTime = true;
    }
    notifyListeners();
    listeningSetups();

    _sharedPreferences?.setBool(prefName, receiveKeys);
  }

  resetFirstTime() {
    _firstTime = true;
  }

  listeningSetups() {
    if (receiveKeys) {
      FirebaseMessaging.instance;
      FirebaseMessaging.onBackgroundMessage(_onMessageHandler);
      _firebaseMessagingSub =
          FirebaseMessaging.onMessage.listen(_onMessageHandler);
    } else {
      if (_firebaseMessagingSub != null) {
        FirebaseMessaging.onBackgroundMessage(
            (message) => Future.delayed(Duration.zero));
        _firebaseMessagingSub!.cancel();
      }
    }
  }
}

Future<void> _onMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('## Got a Firecloud message!');
  print('## Message data: ${message.data}');

  if (message.notification != null) {
    print('## Message also contained a notification: ${message.notification}');
  }

  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
