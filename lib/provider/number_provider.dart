import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier{
  int _index = 0;
  int get index => _index;

  setIndex(){
    _index++;
    notifyListeners();
  }
}