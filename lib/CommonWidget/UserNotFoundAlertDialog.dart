import 'package:flutter/material.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

Future<dynamic> userNotFound(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(LocaleKeys.Error.tr().toUpperCase())),
      content: Text(LocaleKeys.UserNotFound.tr()),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(LocaleKeys.Okay.tr().toUpperCase()),
        ),
      ],
    ),
  );
}