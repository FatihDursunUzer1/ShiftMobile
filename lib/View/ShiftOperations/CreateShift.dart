import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shift/CommonWidget/CircularProgressBar.dart';
import 'package:shift/CommonWidget/EButton.dart';
import 'package:shift/CommonWidget/ShiftAppBarWithoutActions.dart';
import 'package:shift/CommonWidget/UserNotFoundAlertDialog.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/View/LoginPage.dart';
import 'package:shift/app/Constants/ColorTable.dart';
import 'package:shift/app/SizeConfig.dart';
import 'package:shift/app/Validators.dart';
import 'package:shift/generated/locale_keys.g.dart';

class CreateShift extends StatefulWidget {
  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends BaseState<CreateShift> {
  TextEditingController? _registrationNumberController;
  bool? _firstSearchButton;
  bool? _secondSearchButton;
  DateTime? _startedTime;
  DateTime? _endTime;
  late DateFormat _formattedDate;
  TextEditingController? _shiftPerson;
  TextEditingController? _transferPerson;

  @override
  void initState() {
    super.initState();
    _registrationNumberController = TextEditingController();
    _firstSearchButton = false;
    _secondSearchButton = false;
    _formattedDate = DateFormat('dd.MM.yyyy  kk:mm');
    _startedTime = DateTime.now();
    _endTime = DateTime.now();
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
      /* Future.delayed(Duration.zero).then((_) {
        setState(() {
          if (flag == true)
            _firstSearchButton = false;
          else
            _secondSearchButton = false;
        });
      }); */
    } else {
      Future.delayed(Duration.zero).then((_) {
        setState(() {
          if (flag == true)
            _firstSearchButton = true;
          else
            _secondSearchButton = true;
        });
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
                  initialDate: starttime==LocaleKeys.StartTime.tr()?_startedTime!:_endTime!,
                  firstDate: starttime==LocaleKeys.StartTime.tr()?DateTime.now():_startedTime!,
                  lastDate: DateTime(2023, 8)));
              final timePicker = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_startedTime!));
              setState(() {
                if (starttime == LocaleKeys.StartTime.tr())
                  {
                  _startedTime = time!.add(Duration(
                      hours: timePicker!.hour, minutes: timePicker.minute));
                  }
                if (_endTime!.isBefore(_startedTime!)) {
                  _endTime = _startedTime;
                  _startedTime!.add(Duration(
                      hours: timePicker!.hour, minutes: timePicker.minute));
                } else if (starttime == LocaleKeys.EndTime.tr()) {
                  _endTime = time!.add(Duration(
                      hours: timePicker!.hour, minutes: timePicker.minute));
                }
              });
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
                  _firstSearchButton == false ? null : (){
                    search();
                  },
                  true),
              dateRow(starttime: LocaleKeys.StartTime.tr(), time: _startedTime!),
              dateRow(starttime: LocaleKeys.EndTime.tr(), time: _endTime!),
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
                  _secondSearchButton == false
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
