import 'package:flutter/material.dart';
import 'package:shift/app/Enums/UserType.dart';

abstract class User{
  String? registrationNumber;
  String? _userName;
  UserType? _userType;
  User.init();
  User({required this.registrationNumber
    ,required String userName, required UserType userType})
  {
    this._userName=userName;
    this._userType=userType;
  }

  UserType? get userType => _userType;

  set userType(UserType? value) {
    _userType = value;
  }
  String? get userName => _userName;

  set userName(String? value) {
    _userName = value;
  }
}