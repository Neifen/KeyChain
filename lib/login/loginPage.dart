import 'package:flutter/material.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:key_chain/keychain/db/key_saver.dart';
import 'package:key_chain/keychain/key_reciever.dart';
import 'package:key_chain/login/logoutPage.dart';
import 'package:key_chain/login/registerPage.dart';
import 'package:provider/provider.dart';

import 'authProvider.dart';

class LoginPage extends StatelessWidget {
  static const String route = 'login';

  showLoginDialog(BuildContext context, String _email, String _password) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget resetButton = ElevatedButton(
      child: Text("Remove Offline Keys"),
      onPressed: () async {
        Navigator.of(context).pop();
        if ((await Provider.of<AuthProvider>(context, listen: false)
                .login(context, email: _email, password: _password) !=
            null)) {
          await KeySaver().loginAndOnlyTakeFireDB(_email);
          context.read<KeyReciever>().loadKeys();
        }
      },
    );
    Widget keepButton = ElevatedButton(
      child: Text("Mix"),
      onPressed: () async {
        Navigator.of(context).pop();
        if ((await Provider.of<AuthProvider>(context, listen: false)
                .login(context, email: _email, password: _password) !=
            null)) {
          await KeySaver().loginAndMix(_email);
          context.read<KeyReciever>().loadKeys();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text(
          "Would you like to mix your offline and online keys or only keep your online keys?"),
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
    var _key = GlobalKey<FormState>();
    String? _password;
    String? _email;

    return MyScaffold(
        body: Consumer<AuthProvider>(builder: (_, loginData, ___) {
      if (loginData.isLoggedIn()) {
        return LogoutPage();
      }

      return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Text(
                'Login Information',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                onSaved: (value) => _email = value,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address"),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                onSaved: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    final form = _key.currentState!;
                    form.save();
                    if (form.validate() &&
                        _email != null &&
                        _password != null) {
                      showLoginDialog(context, _email!, _password!);
                    }
                  },
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.route);
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      );
    }));
  }
}
