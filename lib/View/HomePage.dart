
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shift/CommonWidget/CircularProgressBar.dart';
import 'package:shift/CommonWidget/EButton.dart';
import 'package:shift/CommonWidget/Empty.dart';
import 'package:shift/CommonWidget/ExitAlertDialog.dart';
import 'package:shift/CommonWidget/GreenContainer.dart';
import 'package:shift/CommonWidget/RedNotification.dart';
import 'package:shift/CommonWidget/ShiftAppBarWithActions.dart';
import 'package:shift/Model/Concrete/Shift.dart';
import 'package:shift/Model/Concrete/Worker.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/View/ShiftOptionsScreen.dart';
import 'package:shift/View/LoginPage.dart';
import 'package:shift/View/ShiftOperations/CreateShift.dart';
import 'package:shift/ViewModel/ShiftModel.dart';
import 'package:shift/ViewModel/UserModel.dart';
import 'package:shift/app/Constants/ColorTable.dart';
import 'package:shift/app/Constants/PreferencesConstant.dart';
import 'package:shift/app/Enums/UserType.dart';
import 'package:shift/app/PreferenceUtils.dart';
import 'package:shift/app/SizeConfig.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  late DateFormat _formattedDate;
  UserType? userType;

  @override
  void initState() {
    super.initState();
    var regNumber=PreferenceUtils.getString(PreferencesConstants.REG_NUMBER);
    if(regNumber!=null)
      {
        context.read<UserModel>().user=Worker(userName: "Ender Erdihan", userType: UserType.WORKER,registrationNumber:regNumber);
      }
    _formattedDate = DateFormat('dd.MM.yyyy  kk:mm');
    userType= UserType.CHIEF;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: shiftAppBarWithActions(exit: (){
          exit(context);
        }),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context,snapshot)
          {
            debugPrint(snapshot.connectionState.toString());
            if(snapshot.connectionState==ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    greenContainer(
                      child: userInfoArea(),
                      //width: SizeConfig.safeBlockHorizontal*100,
                      //height:100.0,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, int) {
                        return shiftDetail(
                            name: "Ender Erdihan",
                            startTime: DateTime(2017, 9, 7, 17, 30),
                            endTime: DateTime(2017, 9, 7, 17, 30),
                            shiftPeriodEndTime: DateTime(2017, 9, 7, 17, 30),
                            shiftPeriodStartTime: DateTime(2017, 9, 7, 17, 30),
                            personToChangeShift: "Yucel Cicek");
                      },
                      itemCount: 4,
                    ),
                    userType == UserType.WORKER
                        ? Empty()
                        : Padding(
                      child: EButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateShift()));
                          },
                          backgroundColor: colorTable['green'],
                          text: LocaleKeys.CreateNewShift.tr()),
                      padding: EdgeInsets.all(16),
                    )
                  ],
                ),
              );
            }
            else
              return
                  CircularProgressBar();

          },
        ));
  }

  userInfoArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        userInfo(
            property: LocaleKeys.UserName.tr()+" :",
            value: context.read<UserModel>().user.userName),
        userInfo(property: LocaleKeys.UserRole.tr()+" :", value: "Şef"),
      ],
    );
  }

  userInfo({required String property, required String value}) {
    return Row(
      children: [
        Text(property, style: TextStyle(color: Colors.white)),
        SizedBox(width: 15),
        Text(value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
      ],
    );
  }

  shiftDetail(
      {required String name,
      required DateTime startTime,
      required DateTime endTime,
      required DateTime shiftPeriodStartTime,
      required DateTime shiftPeriodEndTime,
      required String personToChangeShift}) {

    int notification=1;
    return InkWell(
      onTap: (){
        if(userType==UserType.WORKER) {
          //context.read<ShiftModel>().shift=Shift();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Options()));
        }
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [Card(
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customRow(
                      property: userType == UserType.WORKER
                          ? LocaleKeys.ShiftSuperVisor.tr()
                          : LocaleKeys.ShiftWorker.tr(),
                      name: name),
                  Divider(
                    thickness: 2,
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(LocaleKeys.WorkingTime.tr()+" :",style:TextStyle(fontWeight: FontWeight.bold)),
                    shiftHours(startTime, endTime),
                    Divider(
                      thickness: 2,
                    ),
                  ]),
                  Column(
                    children: [
                      customRow(
                          property: LocaleKeys.ShiftPeriod.tr(),
                          name: personToChangeShift),
                      shiftHours(shiftPeriodStartTime, shiftPeriodEndTime)
                    ],
                  )
                ],
              ),
            ),
          ),redNotification(minSize:25,notification: notification)]
        ),
      ),
    );
  }

  customRow({required String property, required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          property + " :",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(name)
      ],
    );
  }

  shiftHours(DateTime startTime, DateTime endTime) {
    String formattedStartTime = _formattedDate.format(startTime);
    String formattedEndTime = _formattedDate.format(endTime);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(formattedStartTime),
        Text("-"),
        Text(formattedEndTime),
      ],
    );
  }
}
