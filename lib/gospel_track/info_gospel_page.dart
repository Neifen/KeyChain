import 'package:flutter/material.dart';
import 'package:key_chain/gospel_track/gospel_track_page.dart';
import 'package:key_chain/gospel_track/page_number.dart';
import 'package:provider/provider.dart';

class InfoGospelPage extends ModalRoute {
  @override
  Color? get barrierColor => Colors.white;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => "GospelInfoPage";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    int _currentPage = context.read<PageNumber>().currentPage;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta != null && details.primaryDelta! > 9) {
          Navigator.pushNamedAndRemoveUntil(
              context, GospelTrackPage.route, (route) => route.isFirst);
        }
      },
      onHorizontalDragUpdate: (details) {
        if (_currentPage < 4 &&
            details.primaryDelta != null &&
            details.primaryDelta! < -9) {
          context.read<PageNumber>().changePage(_currentPage + 1);
          Navigator.pushReplacement(context, InfoGospelPage());
        } else if (_currentPage > 0 &&
            details.primaryDelta != null &&
            details.primaryDelta! > 9) {
          context.read<PageNumber>().changePage(_currentPage - 1);
          Navigator.pushReplacement(context, InfoGospelPage());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                    "Here we'll show some infos about gospel page #${_currentPage + 1}"),
                Text("slide up to go back to your gospel page"),
                Text("slide right to get to to the next page"),
                Text("slide left to go to the last page")
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}
