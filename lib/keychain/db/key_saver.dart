import 'dart:async';

import 'package:key_chain/keychain/db/firedb_key_controller.dart';
import 'package:key_chain/keychain/db/key_controller_state.dart';
import 'package:key_chain/keychain/db/sqlite_key_controller.dart';
import 'package:key_chain/login/loginData.dart';

import '../key_entity.dart';

class KeySaver {
  late IKeyControllerState _currentState;

  // Singleton
  //todo: find out why the private constructor is needed
  static final KeySaver _instance = KeySaver._privateConstructor();
  KeySaver._privateConstructor() {
    if (LoginData().isLoggedIn()) {
      _currentState = FireDBKeyController(LoginData().getUser()!.email!);
    } else {
      _currentState = SQLiteKeyController();
    }
  }

  factory KeySaver() {
    return _instance;
  }

  login(String userId) {
    if (_currentState is FireDBKeyController) return;
    _switchState(FireDBKeyController(userId));
  }

  logout() {
    if (_currentState is SQLiteKeyController) return;
    _switchState(SQLiteKeyController());
  }

  _switchState(IKeyControllerState newState) async {
    var keys = await _currentState.keys();
    newState.insertAll(keys);
    _currentState.deleteAll();

    _currentState = newState;
  }

  deleteKey(KeyEntity key) async {
    return _currentState.deleteKey(key);
  }

  insertKey(KeyEntity key) async {
    return _currentState.insertKey(key);
  }

  Future<int> count() async {
    return _currentState.count();
  }

  Future<List<KeyEntity>> keys() async {
    return _currentState.keys();
  }
}
