import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:key_chain/gospel_track/gospel_track_page.dart';
import 'package:key_chain/gospel_track/page_number.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PageNumber())],
      child: MaterialApp(
        title: 'Gospel Track',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: GospelTrackPage(),
      ),
    );
  }
}
