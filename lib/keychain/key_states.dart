import 'package:flutter/material.dart';
import 'package:key_chain/keychain/db/key_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyStates extends ChangeNotifier {
  static String prefName = 'receiveKeys';
  SharedPreferences? sharedPreferences;

  KeyStates() {
    //SharedPreferences preferences
    loadPreference();
  }
  bool receiveKeys = false, _firstTime = true;

  loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var savedPref = sharedPreferences!.getBool(prefName);
    if (savedPref != null && savedPref) {
      receiveKeys = true;
      _firstTime = false;
      notifyListeners();
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

    sharedPreferences?.setBool(prefName, receiveKeys);
  }

  resetFirstTime() {
    _firstTime = true;
  }
}
