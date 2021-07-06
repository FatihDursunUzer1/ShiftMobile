import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shift/CommonWidget/EButton.dart';
import 'package:shift/CommonWidget/GreenContainer.dart';
import 'package:shift/Model/Concrete/Worker.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/View/HomePage.dart';
import 'package:shift/ViewModel/UserModel.dart';
import 'package:shift/app/Constants/AppConstants.dart';
import 'package:shift/app/Constants/ImagePaths.dart';
import 'package:shift/app/Constants/Languages.dart';
import 'package:shift/app/Enums/UserType.dart';
import 'package:shift/app/PreferenceUtils.dart';
import 'package:shift/app/SizeConfig.dart';
import 'package:shift/app/Validators.dart';
import 'package:shift/core/init/LanguageManager.dart';
import 'package:shift/generated/locale_keys.g.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  //late bool _rememberMe;
  bool? _firstTime;
  //bool? _isDisable;
  late TextEditingController _registrationNumberController;
  late GlobalKey<FormState> _loginFormKey;
  SharedPreferences? _prefs;

  //List<DropdownMenuItem> _dropDownItems;

  @override
  void initState() {
    super.initState();
    _registrationNumberController = TextEditingController();
    _loginFormKey = GlobalKey<FormState>();
    //_rememberMe = false;
    _firstTime = true;
    //_isDisable = true;
    context.read<LoginViewModel>().rememberMe=false;
    context.read<LoginViewModel>().isDisable=true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(ApplicationConstants.APP_NAME,
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal * 5,
                fontWeight: FontWeight.normal)),
        leading: Image(
            image: AssetImage(ImagePaths.ShiftLogo), width: 100, height: 50),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: selectLanguage())
        ],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: greenContainer(
              child: Center(child: loginForm()),
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton selectLanguage() {
    List<DropdownMenuItem> _dropDownItems = [];
    _dropDownItems = languages.values.map((e) {
      return (DropdownMenuItem(value: e, child: Text(e)));
    }).toList();
    debugPrint(context.locale.toString());
    if (PreferenceUtils.getString("Language") == null) {
      PreferenceUtils.setString("Language", context.locale.toString());
    }
    return DropdownButton(
        iconSize: 24,
        icon: Icon(Icons.keyboard_arrow_down),
        items: _dropDownItems,
        onChanged: (dynamic value) async {
          if (value == LanguageManager.instance.languages['en-US'])
            context.setLocale(LanguageManager.instance.enLocale);
          else if (value == LanguageManager.instance.languages['tr']) {
             context.setLocale(LanguageManager.instance.trLocale);
          }
          else if (value == LanguageManager.instance.languages['fr'])
            context.setLocale(LanguageManager.instance.frLocale);
        },
        hint: Text(
            changeDropdownText()!),
        value: changeDropdownText()!);
  }

  Form loginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          registrationNumberLetter(),
          registrationNumberArea(),
          circularBoxRow(),
          loginButton(),
        ],
      ),
    );
  }

  String? changeDropdownText()
  {
    if(context.locale==LanguageManager.instance.trLocale)
      return LanguageManager.instance.languages['tr'];
    else if(context.locale==LanguageManager.instance.frLocale)
      return LanguageManager.instance.languages['fr'];
    else
      return LanguageManager.instance.languages['en-US'];
  }

  Text registrationNumberLetter()
  {
    return Text(
      LocaleKeys.RegistrationNumber.tr(),
      style: TextStyle(
        //fontSize: SizeConfig.blockSizeHorizontal*10/3,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  TextFormField registrationNumberArea()
  {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _registrationNumberController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return _registrationNumberValidator(value!);
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: LocaleKeys.RegistrationNumber.tr() + "...",
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: TextStyle(color: Colors.yellow)),
    );
  }

   circularBoxRow()
  {
    return Row(
      children: [
        circularCheckBox(onTap: () {
          context.read<LoginViewModel>().rememberMe=!context.read<LoginViewModel>().rememberMe;
        }),
        SizedBox(width: 15),
        Text(
          LocaleKeys.RememberMe.tr(),
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
  EButton loginButton()
  {
    return EButton(
      onPressed: context.watch<LoginViewModel>().isDisable != true ? formValidator : null,
      text: LocaleKeys.Login.tr(),
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
      backgroundColor: context.watch<LoginViewModel>().isDisable == true ? Colors.grey : Colors.blue,
    );
  }

  circularCheckBox({required Function onTap}) {
    return Center(
        child: InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: context.watch<LoginViewModel>()._rememberMe
              ? Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.white,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  size: 18,
                  color: Colors.blue,
                ),
        ),
      ),
    ));
  }

  _registrationNumberValidator(String registrationNumber) {
    String? errorMessage = registrationNumberValidator(registrationNumber);
    if (errorMessage != null || errorMessage == "") {
      Future.delayed(Duration.zero).then((_) {
        context.read<LoginViewModel>().isDisable=true;
      });
    } else {
      Future.delayed(Duration.zero).then((_) {
        context.read<LoginViewModel>().isDisable=false;
      });
    }
    return errorMessage;
  }

  formValidator() async {
    final SharedPreferences? prefs = await _prefs;
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      context.read<UserModel>().user =
          Worker(userName: "Ender Erdihan", userType: UserType.WORKER,registrationNumber: _registrationNumberController.text);
      if(context.read<LoginViewModel>()._rememberMe==true)
        await PreferenceUtils.setString("RegistrationNumber", _registrationNumberController.text);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
    } else {}
  }
}

class LoginViewModel with ChangeNotifier{
  late bool _rememberMe;
  late bool _isDisable;


  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  bool get isDisable => _isDisable;

  set isDisable(bool value) {
    _isDisable = value;
    notifyListeners();
  }
}
