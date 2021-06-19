import 'package:flutter/material.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:key_chain/login/logoutPage.dart';
import 'package:provider/provider.dart';

import 'loginData.dart';

class LoginPage extends StatelessWidget {
  static const String route = 'login';

  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<FormState>();
    String? _password;
    String? _email;

    return MyScaffold(body: Consumer<LoginData>(builder: (_, loginData, ___) {
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address"),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                onSaved: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
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
                      Provider.of<LoginData>(context, listen: false)
                          .login(email: _email!, password: _password!);
                    }
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      );
    }));
  }
}
