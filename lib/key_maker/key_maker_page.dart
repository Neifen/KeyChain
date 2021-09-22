import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:key_chain/key_maker/created_key_entity.dart';
import 'package:http/http.dart' as http;

class KeyMakerPage extends StatelessWidget {
  static const String route = 'key_maker';

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    final timeController = TextEditingController();
    final textController = TextEditingController();

    DateTime _now = DateTime.now();
    DateTime _setDateTime = DateTime(_now.year, _now.month, _now.day);

    return MyScaffold(
        body: Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Start typing key...",
                ),
                controller: textController,
                maxLines: 3,
                maxLength: 120,
                maxLengthEnforcement: MaxLengthEnforcement.none,
              ),
            ),
            ElevatedButton(
              child: Text("Send"),
              onPressed: () => sendKey(
                  context,
                  CreatedKeyEntity(
                    textController.text,
                    DateTime.now().millisecondsSinceEpoch,
                  )),
            )
          ],
        ),
      ),
    ));
  }

  sendKey(BuildContext context, CreatedKeyEntity key) async {
    FirebaseMessaging _messaging = FirebaseMessaging.instance;

    saveKey(key);

    String? token = await _messaging.getToken(
      vapidKey:
          "BAiZEppdhMMSdEin09V-IxDdCd7yits-JWmHrPM5KUlwbla9Y1qmRh3CU4gzvjVzccFyKABMK0BfdaFuzXR7aR0",
    );
    print('token: $token');
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAvmNqt4U:APA91bE6Psbm6HbuJRlbXreAuzJoVduZCy_dbp8nth4sXLHDnrOFW7SjWY80v-v2RHOuMrqafXCkVYPZNWx-KKnl1UelboRUCkXeWIDH_wZPnb5cNpyRX9zXmZ16iH8pbW1CERxqQznc"
        },
        body: json.encode({
          "to": token,
          "mutable_content": true,
          "content_available": true,
          "priority": "high",
          "data": {
            "content": {
              "id": 100,
              "channelKey": "key_channel",
              "title": "A new Key has arrived!",
              "body": key.text,
              "notificationLayout": "BigText",
              "showWhen": true,
              "autoCancel": true,
              "privacy": "Private",
              "timestamp": key.timeStamp
            },
            "actionButtons": [
              {"key": "KEEP", "label": "keep", "autoCancel": true}
            ]
          },
          "android": {"priority": "high"}
        }));

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Text('successfully sent'),
        leading: const Icon(Icons.info),
        backgroundColor: Colors.yellow,
        actions: [
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          ),
        ],
      ),
    );
    print(response.body);
  }

  saveKey(CreatedKeyEntity key) async {
    FirebaseDatabase(databaseURL: "https://burnapp-fca75.firebaseio.com/")
        .reference()
        .child("createdKeys/${key.timeStamp}")
        .set(key.text);
  }
}
