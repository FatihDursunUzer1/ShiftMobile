import 'package:flutter/material.dart';
import 'package:shift/CommonWidget/EButton.dart';
import 'package:shift/CommonWidget/ShiftAppBarWithoutActions.dart';
import 'package:shift/View/Abstract/BaseState.dart';
import 'package:shift/View/ShiftOperations/WorkerShiftOperations.dart';
import 'package:shift/ViewModel/ShiftModel.dart';
import 'package:shift/app/Constants/ColorTable.dart';
import 'package:shift/app/Enums/WorkerShiftOperationType.dart';
import 'package:shift/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shift/app/SizeConfig.dart';
import 'package:provider/provider.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends BaseState<Options> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: shiftAppBarWithoutActions(
          onTap: () {
            Navigator.pop(context);
          },
          title: LocaleKeys.SelectAction.tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EButton(
                backgroundColor: colorTable['green'],
                onPressed: context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.START
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WorkerShiftOperations(Title:LocaleKeys.ShiftStartRule.tr())));
                      }
                    : null,
                text: LocaleKeys.Start.tr(),
                icon: Icon(Icons.keyboard_arrow_right),
              ),
              EButton(
                onPressed: context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.TRANSFER
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WorkerShiftOperations(Title:LocaleKeys.ShiftTransferRule.tr())));
                      }
                    : null,
                text: LocaleKeys.Transfer.tr(),
                backgroundColor: colorTable['green'],
                icon: Icon(Icons.keyboard_arrow_right),
              ),
              EButton(
                backgroundColor: colorTable['green'],
                onPressed: context.read<ShiftModel>().shiftOperationType==WorkerShiftOperationType.END
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WorkerShiftOperations(Title:LocaleKeys.ShiftEndRule.tr())));
                      }
                    : null,
                text: LocaleKeys.FinishIt.tr(),
                icon: Icon(Icons.keyboard_arrow_right),
              )
            ],
          ),
        ),
      ),
    );
  }
}
