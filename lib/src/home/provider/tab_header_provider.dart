import 'package:flutter/material.dart';

class TabHeaderProvider extends ChangeNotifier {
  int _seleted = 0;

  int get selected => _seleted;

  void changeSelection(int value) {
    _seleted = value;
    notifyListeners();
  }
}
