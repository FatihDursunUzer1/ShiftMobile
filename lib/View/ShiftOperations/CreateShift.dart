import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shift/CommonWidget/CircularProgressBar.dart';
import 'package:shift/CommonWidget/EButton.dart';
import 'package:shift/CommonWidget/ShiftAppBarWithoutActions.dart';
import 'package:shift/CommonWidget/UserNotFoundAlertDialog.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/View/LoginPage.dart';
import 'package:shift/ViewModel/CreateShiftViewModel.dart';
import 'package:shift/app/Constants/ColorTable.dart';
import 'package:shift/app/SizeConfig.dart';
import 'package:shift/app/Validators.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

class CreateShift extends StatefulWidget {
  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends BaseState<CreateShift> {
  TextEditingController? _registrationNumberController;

  late DateFormat _formattedDate;
  TextEditingController? _shiftPerson;
  TextEditingController? _transferPerson;

  @override
  void initState() {
    super.initState();
    _registrationNumberController = TextEditingController();
    context.read<CreateShiftModelView>().firstSearchButton=false;
    context.read<CreateShiftModelView>().secondSearchButton=false;
    _formattedDate = DateFormat('dd.MM.yyyy  kk:mm');
    context.read<CreateShiftModelView>().startedTime = DateTime.now();
    context.read<CreateShiftModelView>().endTime = DateTime.now();
    _shiftPerson = TextEditingController();
    _transferPerson = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: MediaQuery.of(context).orientation==Orientation.landscape?true:false,
      appBar: shiftAppBarWithoutActions(
          onTap: () {
            Navigator.pop(context);
          },
          title: LocaleKeys.NewShift.tr()),
      body: OrientationBuilder(builder:(context,orientation)
      {
        return orientation==Orientation.landscape?SingleChildScrollView(
            child:_createShiftContainer()
        ):_createShiftContainer();
      })
    );
  }

  registrationNumberTextArea(TextEditingController? registrationNumberController,
      Function validator, Function? searchButtonOnPressed, bool flag) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Container(
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: registrationNumberController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return validator(value, flag);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(
                      100, 243, 242, 242))
                    ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: LocaleKeys.RegistrationNumber.tr() + "...",
                  hintStyle: TextStyle(
                      color: Colors.black)),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [_searchButton(onPressed: searchButtonOnPressed)],
              )),
        ],
      ),
    );
  }

  _registrationNumberValidator(String value, bool flag) {
    String? errorMessage = registrationNumberValidator(value);
    if (errorMessage != null || errorMessage == "") {
       Future.delayed(Duration.zero).then((_) {
          if (flag == true)
            context.read<CreateShiftModelView>().firstSearchButton=false;
          else
            context.read<CreateShiftModelView>().secondSearchButton=false;
      });
    } else {
      Future.delayed(Duration.zero).then((_) {

          if (flag == true)
            context.read<CreateShiftModelView>().firstSearchButton=true;
          else
            context.read<CreateShiftModelView>().secondSearchButton=true;
      });
    }
    return errorMessage;
  }

  dateRow({required String starttime, required DateTime? time}) {
    String formattedDate = _formattedDate.format(time as DateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(starttime + " :",
              style: TextStyle(fontSize:18)),
          InkWell(
            child: Text(
              formattedDate,style:
            TextStyle(fontSize: 18)
            ),
            onTap: () async {
              time = await (showDatePicker(
                  initialDatePickerMode: DatePickerMode.day,
                  context: context,
                  initialDate: starttime==LocaleKeys.StartTime.tr()?context.read<CreateShiftModelView>().startedTime:context.read<CreateShiftModelView>().endTime,
                  firstDate: starttime==LocaleKeys.StartTime.tr()?DateTime.now():context.read<CreateShiftModelView>().startedTime,
                  lastDate: DateTime(2023, 8)));
              if(time!=null) {
                final timePicker = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(context
                        .read<CreateShiftModelView>()
                        .startedTime));

                if (starttime == LocaleKeys.StartTime.tr()) {
                  context
                      .read<CreateShiftModelView>()
                      .startedTime = time!.add(Duration(
                      hours: timePicker!.hour, minutes: timePicker.minute));
                }
                if (context
                    .read<CreateShiftModelView>()
                    .endTime
                    .isBefore(context
                    .read<CreateShiftModelView>()
                    .startedTime)) {
                  context
                      .read<CreateShiftModelView>()
                      .endTime = context
                      .read<CreateShiftModelView>()
                      .startedTime;
                  context
                      .read<CreateShiftModelView>()
                      .startedTime
                      .add(Duration(
                      hours: timePicker!.hour, minutes: timePicker.minute));
                } else if (starttime == LocaleKeys.EndTime.tr()) {
                  context
                      .read<CreateShiftModelView>()
                      .endTime = time!.add(Duration(
                      hours: timePicker!.hour, minutes: timePicker.minute));
                }
              }
            },
          )
        ],
      ),
    );
  }

  _searchButton({required Function? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      child: Text(LocaleKeys.Search.tr()),
      style: ButtonStyle(backgroundColor:
          MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return Colors.grey;
        return colorTable['green'];
      })),
    );
  }
  Container _createShiftContainer()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical:24,horizontal: 16),
      //height: SizeConfig.safeBlockHorizontal*15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.BeginShiftPerson.tr() + " :",
                style: TextStyle( fontSize: 16),
              ),
              registrationNumberTextArea(
                  _registrationNumberController,
                  _registrationNumberValidator,
              context.watch<CreateShiftModelView>().firstSearchButton == false ? null : (){
                    search();
                  },
                  true),
              dateRow(starttime: LocaleKeys.StartTime.tr(), time: context.read<CreateShiftModelView>().startedTime),
              dateRow(starttime: LocaleKeys.EndTime.tr(), time: context.read<CreateShiftModelView>().endTime),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Text(
                LocaleKeys.TransferShiftPerson.tr() + " :",
                style: TextStyle(fontSize: 16),
              ),
              registrationNumberTextArea(
                  _transferPerson,
                  _registrationNumberValidator,
  context.watch<CreateShiftModelView>().secondSearchButton == false
                      ? null
                      :(){
                    search();
                  },
                  false),
            ],
          ),
          EButton(onPressed: () {}, text: LocaleKeys.CreateShift.tr())
        ],
      ),
    );
  }

  search()async
  {
    userNotFound(context);
  }


/*() {  Loading Button
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (i, x, y) {
                              return CircularProgressBar();
                            }));
                  }, */
}
