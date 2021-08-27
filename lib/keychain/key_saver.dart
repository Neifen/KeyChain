import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/keychain/key_entity.dart';

class KeySaver extends ChangeNotifier {
  List<KeyEntity> _keyList = [];

  List get keyList => List.unmodifiable(_keyList);

  KeySaver() {
    loadKeys();
    AwesomeNotifications().actionStream.listen(_onNotificationAction);
  }

  void loadKeys() async {
    _keyList = await KeyEntity.keys();
    notifyListeners();
  }

  void _onNotificationAction(ReceivedAction event) {
    if (event.body != null) {
      var key = KeyEntity(
          content: event.body!, receptionDateTime: DateTime.now().toString());
      _keyList.add(key);
      notifyListeners();

      KeyEntity.insertKey(key);
    }
  }
}
