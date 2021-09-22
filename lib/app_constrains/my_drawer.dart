import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:key_chain/contact/contact_page.dart';
import 'package:key_chain/gospel_track/gospel_track_page.dart';
import 'package:key_chain/key_maker/key_maker_page.dart';
import 'package:key_chain/keychain/keychain_page.dart';
import 'package:key_chain/login/authProvider.dart';
import 'package:key_chain/login/loginPage.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  Widget _createAdminDrawerItem(BuildContext context,
      {required String text,
      required String page,
      IconData? iconData,
      required AuthProvider auth}) {
    if (auth.isAdmin()) {
      return ListTile(
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        ),
        trailing: Icon(iconData),
        onTap: () => Navigator.pushNamed(context, page),
      );
    } else {
      return Divider(
        height: 0,
      );
    }
  }

  Widget _createOnlineOfflineDrawerItem(BuildContext context,
      {required String onlineText,
      required String offlineText,
      required String page,
      IconData? iconData,
      required AuthProvider auth}) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(auth.isLoggedIn() ? onlineText : offlineText),
      ),
      trailing: Icon(iconData),
      onTap: () => Navigator.pushNamed(context, page),
    );
  }

  Widget _createDrawerItem(BuildContext context,
      {required String text, required String page, IconData? iconData}) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(text),
      ),
      trailing: Icon(iconData),
      onTap: () => Navigator.pushNamed(context, page),
    );
  }

  Widget _createHeader(String _text) {
    return DrawerHeader(
        child: Stack(children: <Widget>[
      Positioned(
          bottom: 12.0,
          left: 16.0,
          child: Text(_text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500))),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, data, ___) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _createHeader("my app"),
            _createDrawerItem(
              context,
              text: 'My Keychain',
              page: KeyChainPage.route,
              iconData: Icons.dns_outlined,
            ),
            _createOnlineOfflineDrawerItem(context,
                offlineText: 'Save Keys to cloud / Login',
                onlineText: 'Logout',
                page: LoginPage.route,
                iconData: Icons.login_outlined,
                auth: data),
            _createAdminDrawerItem(
              context,
              text: 'Keymaker',
              page: KeyMakerPage.route,
              iconData: CupertinoIcons.hammer,
              auth: data,
            ),
            _createDrawerItem(context,
                text: 'Contact us',
                page: ContactPage.route,
                iconData: Icons.contact_page_outlined),
            Divider(),
            _createDrawerItem(
              context,
              text: 'What are we about',
              page: GospelTrackPage.route,
              iconData: CupertinoIcons.question_square,
            )
          ],
        ),
      ),
    );
  }
}
