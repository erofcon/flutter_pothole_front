import 'package:flutter/material.dart';

class ChangeData with ChangeNotifier {
  bool _isLoading = false;
  DateTime? _dateTime;

  DateTime? get dateTime => _dateTime;
  dynamic _file;
  int _progress = 0;

  dynamic get file => _file;

  int get progress => _progress;

  bool get isLoading => _isLoading;

  void changeLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }

  void changeDateTime(DateTime? dateTime) {
    _dateTime = dateTime;

    notifyListeners();
  }

  void changeFile(dynamic file) {
    _file = file;

    notifyListeners();
  }

  void changeProgress(int progress) {
    _progress = progress;

    notifyListeners();
  }
}
