import 'package:easy_localization/easy_localization.dart';
import 'package:shift/generated/locale_keys.g.dart';

registrationNumberValidator(String registrationNumber) {
  String? errorMessage;
  if (registrationNumber.length < 6) {
    errorMessage = LocaleKeys.RegistrationNumberError.tr();
  }
  return errorMessage;
}