import 'package:flutter/material.dart';
import 'package:shift/CommonWidget/Empty.dart';
import 'package:shift/CommonWidget/RedNotification.dart';
import 'package:shift/app/Constants/AppConstants.dart';
import 'package:shift/app/Constants/ColorTable.dart';
import 'package:shift/app/Constants/ImagePaths.dart';

AppBar shiftAppBarWithActions({Function? exit}) {
  int notification=5; //notification counter
  return AppBar(
    backgroundColor: colorTable['darkgreen'],
    leading: Image.asset(
      ImagePaths.ShiftLogo,
    ),
    title: Text(ApplicationConstants.APP_NAME,style: TextStyle(fontSize: 36,fontWeight: FontWeight.normal),),
    centerTitle: false,
    titleSpacing: 0,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              debugPrint("Bildirim Sayfası");
            },
            child: new Stack(
              children: <Widget>[
                new Icon(Icons.notifications),
                notification>0?
                redNotification(minSize: 9):Empty()
              ],
            ),
          ),
        ],
      ),
      IconButton(icon: Icon(Icons.exit_to_app_sharp),onPressed: (){exit!();},)
    ],
  );


}
