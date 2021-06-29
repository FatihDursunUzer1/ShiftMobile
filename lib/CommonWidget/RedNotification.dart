
import 'package:flutter/material.dart';

redNotification({required double minSize,int? notification})
{
  return new Positioned(
    right: 0,
    child: new Container(
      decoration: new BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(minSize/2),
      ),
      constraints: BoxConstraints(
        minWidth: minSize,
        minHeight: minSize,
      ),
      child:notification!=null?Center(child: Text(notification.toString(),style: TextStyle(color:Colors.white,fontSize: minSize/1.5),)):null,
    ),
  );
}