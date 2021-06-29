
import 'package:flutter/material.dart';
import 'package:shift/Model/Concrete/Shift.dart';
import 'package:shift/app/Enums/WorkerShiftOperationType.dart';

class ShiftModel with ChangeNotifier{
  Shift? _shift;
  WorkerShiftOperationType? shiftOperationType;

  ShiftModel()
  {
    if(!isReadyForTransfer())
      shiftOperationType=WorkerShiftOperationType.TRANSFER;
    else if(isReadyForEnd())
      shiftOperationType=WorkerShiftOperationType.END;
    else
      shiftOperationType=WorkerShiftOperationType.START;
  }

  Shift? get shift => _shift;

  set shift(Shift? value) {
    _shift = value;
    notifyListeners();
  }


  bool isReadyForEnd()
  {
    /* if(shift!.isShiftTransferred==true || (shift!.shiftTransferStartedPicturePath!=null && shift!.isShiftTransferred==false))
      return true;
    else
      return false; */
    return true;
  }
  bool isReadyForTransfer()
  {
    /*if(shift!.isShiftTransferred==false && (shift!.transferredWorkerName!=null && shift!.shiftTransferredPicturePath==null))
      return true;
    return false; */
    return true;
  }
}