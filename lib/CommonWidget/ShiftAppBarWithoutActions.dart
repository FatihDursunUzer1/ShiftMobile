import 'package:flutter/material.dart';
import 'package:shift/app/Constants/ColorTable.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

shiftAppBarWithoutActions({Function? onTap,required String title})
{
  return  AppBar(
    backgroundColor: colorTable['darkgreen'],
    title: Text(title),
    centerTitle: true,
    leading: InkWell(
      onTap:onTap as void Function()?,
      child: Row(
        children: [
          Icon(
            Icons.keyboard_arrow_left,
            size: 24,
          ),
          Expanded(child: Text(LocaleKeys.Back.tr()))
        ],
      ),
    ),
    automaticallyImplyLeading: false,
  );
}