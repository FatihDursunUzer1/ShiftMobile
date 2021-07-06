import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shift/View/HomePage.dart';
import 'package:shift/View/LoginPage.dart';
import 'package:shift/ViewModel/CreateShiftViewModel.dart';
import 'package:shift/ViewModel/UserModel.dart';
import 'package:shift/app/Constants/AppConstants.dart';
import 'package:shift/app/Constants/PreferencesConstant.dart';
import 'package:shift/app/PreferenceUtils.dart';
import 'package:shift/core/init/LanguageManager.dart';
import 'package:shift/locator.dart';
import 'View/LandingPage.dart';
import 'ViewModel/ShiftModel.dart';

void main() async {
  await init();
  debugPrint(PreferenceUtils.getString(PreferencesConstants.REG_NUMBER));
  runApp(
    EasyLocalization(
      supportedLocales:
        LanguageManager.instance.supportedLocales
      ,
      path: ApplicationConstants.LOCALIZATION_PATH,
      child:MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserModel()),
            ChangeNotifierProvider(create: (_) => ShiftModel()),
            ChangeNotifierProvider(create: (_)=>LoginViewModel()),
            ChangeNotifierProvider(create: (_)=>CreateShiftModelView())
          ], child:MyApp(),) ,
    ),
  );
}

Future<void> init()
async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await PreferenceUtils.init();
  await EasyLocalization.ensureInitialized();
}


class MyApp extends StatelessWidget {

  String? _prefs=PreferenceUtils.getString(PreferencesConstants.REG_NUMBER);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          cupertinoOverrideTheme: CupertinoThemeData(
              brightness: Brightness.dark,
              primaryContrastingColor: Colors.white,
              barBackgroundColor: Colors.white)),
      home:_prefs==null?LoginPage():HomePage(),
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
