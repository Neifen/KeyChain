import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/keychain/db/key_saver.dart';
import 'package:key_chain/keychain/key_entity.dart';

class KeyReciever extends ChangeNotifier {
  List<KeyEntity> _keyList = [];
  List get keyList => List.unmodifiable(_keyList);

  KeyReciever() {
    loadKeys();
    AwesomeNotifications().actionStream.listen(_onNotificationAction);
  }

  void loadKeys() async {
    _keyList = await KeySaver().keys();
    notifyListeners();
  }

  void _onNotificationAction(ReceivedAction event) {
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
