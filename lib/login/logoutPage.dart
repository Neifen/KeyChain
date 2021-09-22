import 'package:flutter/material.dart';
import 'package:key_chain/keychain/db/key_saver.dart';
import 'package:key_chain/keychain/key_reciever.dart';
import 'package:provider/provider.dart';

import 'authProvider.dart';

class LogoutPage extends StatelessWidget {
  showLogoutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget resetButton = ElevatedButton(
      child: Text("Reset"),
      onPressed: () async {
        Navigator.of(context).pop();
        await KeySaver().logoutAndReset();
        await context.read<AuthProvider>().logout();
        context.read<KeyReciever>().loadKeys();
      },
    );
    Widget keepButton = ElevatedButton(
      child: Text("Keep"),
      onPressed: () async {
        Navigator.of(context).pop();
        await KeySaver().logoutAndKeep();
        context.read<AuthProvider>().logout();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text(
          "Would you like to keep your keys in offline-mode or reset your keychain"),
      actions: [keepButton, resetButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Welcome ${context.read<AuthProvider>().getUser()!.email}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
