import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shift/CommonWidget/EButton.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/app/Constants/ImagePaths.dart';
import 'package:shift/generated/locale_keys.g.dart';

class Approve extends StatefulWidget {
  const Approve({Key? key}) : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends BaseState<Approve> {
  late String _text;
  late String bytes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _text="XX çalışanı mesaisini bitirmiştir. Onaylıyor musunuz?";
    //bytes=Image(image: image); //veri tabanından fotoğraf çekilecek
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Card(
      child: Center(child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly

        ,
        children: [
          Text(_text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16
          ),),
          Image.memory(base64Decode(bytes),height:dynamicHeight(0.3)),
          EButton(text: LocaleKeys.Approve.tr(), onPressed: (){Navigator.pop(context);},),
        ],
      )),
    ),);
  }
}
