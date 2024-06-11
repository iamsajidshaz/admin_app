import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isGoogleSignInClicked = false;
  int _index = 0;

  int get index => _index;

  bool get isGoogleSignInClicked => _isGoogleSignInClicked;

  void setGoogleSignInClicked(bool value) {
    _isGoogleSignInClicked = value;
    notifyListeners();
  }

  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}
