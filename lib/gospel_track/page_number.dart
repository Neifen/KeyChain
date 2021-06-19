import 'package:flutter/material.dart';

class PageNumber extends ChangeNotifier {
  int currentPage = 0;

  changePage(int newPage) {
    print(newPage);
    currentPage = newPage;
    notifyListeners();
  }
}
