

import 'package:flutter/material.dart';

class CreateShiftModelView with ChangeNotifier{
  late bool _firstSearchButton;
  late bool _secondSearchButton;
  late DateTime _startedTime;
  late DateTime _endTime;


  DateTime get startedTime => _startedTime;

  set startedTime(DateTime value) {
    _startedTime = value;
    notifyListeners();
  }

  bool get firstSearchButton => _firstSearchButton;

  set firstSearchButton(bool value) {
    _firstSearchButton = value;
    notifyListeners();
  }

  bool get secondSearchButton => _secondSearchButton;

  set secondSearchButton(bool value) {
    _secondSearchButton = value;
    notifyListeners();
  }

  DateTime get endTime => _endTime;

  set endTime(DateTime value) {
    _endTime = value;
    notifyListeners();
  }
}