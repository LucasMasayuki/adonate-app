import 'package:clean_architeture_flutter/app/ui/helpers/i18n/resources.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse,
  nothing,
}

extension UIErrorExtension on UIError {
  String? get description {
    switch (this) {
      case UIError.nothing:
        return null;
      case UIError.requiredField:
        return R.string.msgRequiredField;
      case UIError.invalidField:
        return R.string.msgInvalidField;
      case UIError.invalidCredentials:
        return R.string.msgInvalidCredentials;
      case UIError.emailInUse:
        return R.string.msgEmailInUse;
      default:
        return R.string.msgUnexpectedError;
    }
  }
}
