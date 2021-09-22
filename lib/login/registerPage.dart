import 'package:flutter/material.dart';
import 'package:key_chain/app_constrains/my_scaffold.dart';
import 'package:key_chain/login/logoutPage.dart';
import 'package:provider/provider.dart';

import 'authProvider.dart';

class RegisterPage extends StatelessWidget {
  static const String route = 'register';

  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<FormState>();
    String? _password;
    String? _passwordRep;
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
              TextFormField(
                onSaved: (value) => _passwordRep = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Re-enter Password"),
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
                        _password != null &&
                        _password == _passwordRep) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .createUser(context,
                              email: _email!, password: _password!);
                    }
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      );
    }));
  }
}
