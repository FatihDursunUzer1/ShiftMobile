

import 'package:flutter/material.dart';
import 'package:shift/app/Constants/PreferencesConstant.dart';
import 'package:shift/app/PreferenceUtils.dart';

import '../View/LoginPage.dart';
import '../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

Future<dynamic> exit(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(LocaleKeys.PopUpTitleForExit.tr()),
      content: Text(LocaleKeys.PopUpContentForExit.tr()),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(LocaleKeys.No.tr()),
        ),
        TextButton(
          onPressed: () {

            PreferenceUtils.removeKey(PreferencesConstants.REG_NUMBER);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false);},
          /*Navigator.of(context).pop(true)*/
          child: Text(LocaleKeys.Yes.tr()),
        ),
      ],
    ),
  );
}