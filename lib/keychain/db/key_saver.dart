import 'dart:async';

import 'package:key_chain/keychain/db/firedb_key_controller.dart';
import 'package:key_chain/keychain/db/key_controller_state.dart';
import 'package:key_chain/keychain/db/sqlite_key_controller.dart';
import 'package:key_chain/login/authProvider.dart';

import 'key_entity.dart';

class KeySaver {
  late IKeyControllerState _currentState;

  // Singleton
  //todo: find out why the private constructor is needed
  static final KeySaver _instance = KeySaver._privateConstructor();
  KeySaver._privateConstructor() {
    if (AuthProvider().isLoggedIn()) {
      _currentState = FireDBKeyController(AuthProvider().getUser()!.email!);
    } else {
      _currentState = SQLiteKeyController();
    }
  }

  factory KeySaver() {
    return _instance;
  }

  loginAndOnlyTakeFireDB(String userId) async {
    if (_currentState is FireDBKeyController) return;
    _currentState.deleteAll();
    await _switchState(FireDBKeyController(userId));
  }

  loginAndMix(String userId) async {
    if (_currentState is FireDBKeyController) return;
    await _switchState(FireDBKeyController(userId));
  }

  logoutAndKeep() {
    if (_currentState is SQLiteKeyController) return;
    _switchState(SQLiteKeyController());
  }

  logoutAndReset() async {
    if (_currentState is SQLiteKeyController) return;
    await _switchState(SQLiteKeyController());
    _currentState.deleteAll();
  }

  _switchState(IKeyControllerState newState) async {
    var oldKeys = await _currentState.keys();

    await newState.insertAll(oldKeys);

    _currentState = newState;
  }

  removeKey(KeyEntity key) async {
    return _currentState.removeKey(key);
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
