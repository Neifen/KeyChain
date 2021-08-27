import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyStates extends ChangeNotifier {
  static String _pref_name = 'receiveKeys';
  SharedPreferences? sharedPreferences;

  KeyStates() {
    //SharedPreferences preferences
    loadPreference();
  }
  bool receiveKeys = false, _firstTime = true;

  loadPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var savedPref = sharedPreferences!.getBool(_pref_name);
    if (savedPref != null && savedPref) {
      receiveKeys = true;
      _firstTime = false;
      notifyListeners();
    }
  }

  bool get firstTime => _firstTime;

  switchKey() {
    receiveKeys = !receiveKeys;
    _firstTime = false;
    notifyListeners();

    sharedPreferences?.setBool(_pref_name, receiveKeys);
  }
}
