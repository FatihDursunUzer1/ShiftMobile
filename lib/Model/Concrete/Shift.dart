class Shift {
  int id;
  String workerRegNumber;
  String workerCompanyName;
  String workerName;
  String? transferredWorkerRegNumber;
  String? transferredWorkerCompanyName;
  String? transferredWorkerName;
  String? shiftStartedPicturePath;
  String? shiftTransferredPicturePath;
  String? shiftFinishedPicturePath;
  String? shiftTransferStartedPicturePath;
  String shiftTransferFinishedPicturePath;
  String chiefRegistrationNumber;
  String chiefCompanyName;
  String chiefName;
  bool isActive;
  bool isShiftTransferred;
  DateTime shiftStartedDate;
  DateTime shiftEndedDate;
  DateTime shiftTransferStartedDate;
  DateTime shiftTransferEndedDate;
  DateTime? createdDate;
  DateTime? updatedDate;

  Shift({
    required this.id,
    required this.workerRegNumber,
    required this.workerCompanyName,
    required this.workerName,
    this.transferredWorkerRegNumber,
    this.transferredWorkerCompanyName,
    this.transferredWorkerName,
    this.shiftStartedPicturePath,
    this.shiftTransferredPicturePath,
    this.shiftFinishedPicturePath,
    this.shiftTransferStartedPicturePath,
    required this.shiftTransferFinishedPicturePath,
    required this.chiefRegistrationNumber,
    required this.chiefCompanyName,
    required this.chiefName,
    required this.isActive,
    required this.isShiftTransferred,
    required this.shiftStartedDate,
    required this.shiftEndedDate,
    required this.shiftTransferStartedDate,
    required this.shiftTransferEndedDate,
    this.createdDate,
    this.updatedDate
  }); //Değişebilir burası
}
