import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const PUSH_NOTIFICATION_BUTTONS = "actionButtons";
const NOTIFICATION_CHANEL = "key_channel";

class RegisterThings {
  void registerNotification() async {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelKey: NOTIFICATION_CHANEL,
          channelName: 'Key notifications',
          channelDescription: 'Notification channel for our Keys',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ]);

    await Firebase.initializeApp();
    grandPermissions();
  }
}

void grandPermissions() async {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}
