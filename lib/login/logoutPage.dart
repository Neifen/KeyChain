import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loginData.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Welcome ${context.read<LoginData>().getUser()!.email}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                context.read<LoginData>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
