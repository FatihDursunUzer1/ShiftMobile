
import 'package:shift/Model/Abstract/User.dart';
import 'package:shift/Model/Concrete/Worker.dart';
import 'package:shift/app/Enums/UserType.dart';

import 'Shift.dart';

class Chief extends User{
 //List<Worker>? _employees;
Chief.init():super.init();
List<Shift>? shifts;
 Chief({required String userName, required UserType userType,required String registrationNumber}):super(userName: userName,userType:userType,registrationNumber: registrationNumber);
 //Chief.fromMap(Map<String,dynamic> parsedMap){}
 Map<String,dynamic> toMap(){
   return {};
 }

}