import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyStates extends ChangeNotifier {
  KeyStates() {
    //SharedPreferences preferences
  }
  bool receiveKeys = false, _firstTime = true;

  bool get firstTime => _firstTime;

  switchKey() {
    receiveKeys = !receiveKeys;
    _firstTime = false;
    notifyListeners();
  }
}
