
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/CommonWidget/Empty.dart';
import 'package:shift/CommonWidget/ShiftAppBarWithoutActions.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/ViewModel/ShiftModel.dart';
import 'package:shift/ViewModel/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:shift/app/Constants/ImagePaths.dart';
import 'package:shift/app/Enums/WorkerShiftOperationType.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:shift/app/SizeConfig.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';


import '../../CommonWidget/EButton.dart';

class WorkerShiftOperations extends StatefulWidget {
  @override
  _WorkerShiftOperationsState createState() => _WorkerShiftOperationsState();

  late String _title;

  String get title => _title;

  set title(String title) {
    _title = title;
  }

  WorkerShiftOperations({required String Title})
  {
    title=Title;
  }

}

class _WorkerShiftOperationsState extends BaseState<WorkerShiftOperations> {
  File? file;
  final picker = ImagePicker();
   String? img64;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: shiftAppBarWithoutActions(
          title: LocaleKeys.ShiftProcess.tr(),
          onTap: () {
            Navigator.pop(context);
          }),
      body: OrientationBuilder(builder:(context,orientation)
      {
        return orientation==Orientation.landscape?SingleChildScrollView(
            child:_startShiftArea()
        ):_startShiftArea();
      })
    );
  }

  _startShiftArea()
  {

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$userText:"+context.read<UserModel>().user.userName + "\n",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        )),
                Text(
                  widget.title,
                  style: TextStyle(fontSize:16,
                      fontWeight: FontWeight.w500),
                ),
                Text("* " + LocaleKeys.TakePhotoRule.tr() + "\n ",
                    style: TextStyle(
                       )),
                Text("*  " + LocaleKeys.TakeLocationRule.tr() + " \n",
                    style: TextStyle(
                        )),
                takePhoto(),
                img64!=null?Image.memory(base64Decode(img64!)):Empty(),

              ],
            ),
          ),
          startShiftButton(),
        ],
      ),
    );
  }

  String get userText{
    return context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.TRANSFER?LocaleKeys.UserToBeTransferred.tr():LocaleKeys.User.tr();
  }

  checkIfLocationIsMock()
  {
    bool isMock=context.read<UserModel>().isMockLocation();
    if(isMock)
      debugPrint("Mocked Location");
    else debugPrint("is not Mock Location");
  }

  EButton startShiftButton()
  {
    return EButton(
      onPressed: file==null?null:()  async {
        checkIfLocationIsMock();

        var location=await context.read<UserModel>().determinePosition();

        debugPrint(location.toString());
    GeocodingPlatform geo=GeocodingPlatform.instance;
    geo.placemarkFromCoordinates(location!.latitude, location.longitude).then((value){
      debugPrint(value[0].toString());
    });


        var shiftStartedPicturePath="";
        var shiftTransferredPicturePath="";
        var shiftEndedPicturePath;

        /* this.shiftStartedPicturePath,
      this.shiftTransferredPicturePath,
      this.shiftFinishedPicturePath,
      this.shiftTransferStartedPicturePath,
      this.shiftTransferFinishedPicturePath, */
        if(context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.START)
          {
            //StartedPicture kullanılarak Shift update edilecek
          }
        else if(context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.TRANSFER)
          {
            //transferPicture kullanılarak Shift Update edilecek
          }
        else if(context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.END)
          {
            //endPicture kullanılarak Shift update edilecek
          }
      },
      icon: Icon(Icons.check),
      text: EButtonText,
      //height: SizeConfig.safeBlockVertical * 8,
    );
  }

  String get EButtonText{
    if(context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.START)
      return LocaleKeys.Start.tr();
    else if(context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.TRANSFER)
      return LocaleKeys.Transfer.tr();
    else
      return LocaleKeys.FinishIt.tr();
  }

  InkWell takePhoto()
  {
    return InkWell(
        onTap: () async {
          final imagePicker =
          await picker.getImage(source: ImageSource.camera);
          setState(() {
            file = File(imagePicker!.path);
            final bytes = File(file!.path).readAsBytesSync();
            img64 = base64Encode(bytes);
            debugPrint(img64);
          });
        },
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: MediaQuery.of(context).orientation==Orientation.landscape?SizeConfig.safeBlockHorizontal * 35:SizeConfig.safeBlockVertical*35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: (file == null
                      ? AssetImage(ImagePaths.EmptyPhoto)
                      : FileImage(file!)) as ImageProvider<Object>)),
        ));
  }
}
