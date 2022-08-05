import 'package:flutter/material.dart';

class IsLoadingState with ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void changeBool(bool value) {
    _isLoading = value;

    notifyListeners();
  }
}