import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/keychain/db/key_saver.dart';
import 'package:key_chain/keychain/db/key_entity.dart';

class KeyReciever extends ChangeNotifier {
  List<KeyEntity> _keyList = [];
  List get keyList => List.unmodifiable(_keyList);

  KeyReciever() {
    loadKeys();
    AwesomeNotifications().actionStream.listen(_onNotificationAction);
  }

  loadKeys() async {
    _keyList = await KeySaver().keys();
    notifyListeners();
  }

//note: not very pretty to have 2 "controllers" and have this one called reciever. But the key needs to be removed in all UIs
  removeKey(KeyEntity key) {
    _keyList.remove(key);
    notifyListeners();
    KeySaver().removeKey(key);
  }

  void _onNotificationAction(ReceivedAction event) async {
    if (event.body != null) {
      var key = KeyEntity(
          content: event.body!,
          receptionDateTime: DateTime.now().millisecondsSinceEpoch.toString());
      _keyList.add(key);
      notifyListeners();

      KeySaver().insertKey(key);
    }
  }
}
