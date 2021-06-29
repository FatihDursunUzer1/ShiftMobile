import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shift/app/Constants/ImagePaths.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CircularProgressBar extends StatefulWidget {
  @override
  _CircularProgressBarState createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black.withOpacity(0.8),
      body: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: Center(child: Container(
          height:MediaQuery.of(context).size.height/3,
          width:MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(ImagePaths.ShiftLogo),
              CupertinoActivityIndicator(radius: 15,),
              Text(LocaleKeys.Loading.tr()+"...",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
            ],
          ),
        )),
      ),
    );
  }
}
