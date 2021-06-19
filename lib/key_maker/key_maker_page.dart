import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:key_chain/key_maker/key_entity.dart';
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
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Start typing key...",
              ),
              controller: textController,
              maxLines: 3,
              maxLength: 120,
              maxLengthEnforcement: MaxLengthEnforcement.none,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 2,
                  child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        hintText: "Press to choose a date",
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2100));

                        if (date != null) {
                          _setDateTime = DateTime(date.year, date.month,
                              date.day, _setDateTime.hour, _setDateTime.minute);
                          dateController.text =
                              date.toString().substring(0, 10);
                        }
                      }),
                ),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(
                        hintText: "Press to choose a time",
                      ),
                      onTap: () async {
                        var time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          _setDateTime = DateTime(
                              _setDateTime.year,
                              _setDateTime.month,
                              _setDateTime.day,
                              time.hour,
                              time.minute);
                          timeController.text = time.format(context);
                        }
                      }),
                ),
                ElevatedButton(
                  child: Text("Send"),
                  onPressed: () => sendKey(
                      context,
                      KeyEntity(
                        textController.text,
                        _setDateTime,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  sendKey(BuildContext context, KeyEntity key) async {
    FirebaseMessaging _messaging = FirebaseMessaging.instance;

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
              "privacy": "Private"
            },
            "actionButtons": [
              {"key": "KEEP", "label": "keep", "autoCancel": true}
            ]
          },
          "android": {"priority": "high"}
        }));

    showDialog(
        context: context,
        builder: (_) => AlertDialog(title: Text("successfully sent")));
    print(response.body);
  }
}
