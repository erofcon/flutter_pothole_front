
import 'package:flutter/material.dart';

class TestData with ChangeNotifier{

  bool _test = false;


  bool get test =>_test;

  void changeBool(){
    _test=!_test;
    notifyListeners();
  }

}