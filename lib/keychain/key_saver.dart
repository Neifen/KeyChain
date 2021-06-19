import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/keychain/keychain_page.dart';

class KeySaver extends ChangeNotifier {
  List<String> _keyList = [];
  BuildContext context;

  List get keyList => List.unmodifiable(_keyList);

  KeySaver(this.context) {
    AwesomeNotifications().actionStream.listen(_onNotificationAction);
  }

  void _onNotificationAction(ReceivedAction event) {
    if (event.body != null) {
      _keyList.add(event.body!);
      notifyListeners();
    }
  }
}
