import 'package:flutter/cupertino.dart';
import 'package:shift/Model/Abstract/User.dart';
import 'package:shift/Model/Concrete/Chief.dart';
import 'package:shift/app/Enums/UserType.dart';

import 'Shift.dart';

class Worker extends User{
  List<Shift>? shifts;
  Worker({required String userName, required UserType userType,required String registrationNumber}):super(userName: userName,userType:userType,registrationNumber: registrationNumber);

}