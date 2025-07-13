import '../constants/strings/validation_messages.dart';

class AppValidators {
  static bool emailValidator(String email) {
    final emailRegex = RegExp(AppValidationMessages.emailRegx);
    if (!emailRegex.hasMatch(email.toString())) {
      return true;
    }
    return false;
  }

  static bool nameValidator(String name) {
    RegExp nameRegExp = RegExp(AppValidationMessages.nameRegx);
    if (!nameRegExp.hasMatch(name)) {
      return true;
    }
    return false;
  }

  static bool passwordValidator(String value) {
    final RegExp passwordRegExp = RegExp(AppValidationMessages.passwordRegx);
    if (!passwordRegExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool matchValidator(String value1, String value2) {
    if (value1 != value2) {
      return true;
    }
    return false;
  }

  static bool lengthValidator(String value) {
    if (value.length < 6) {
      return true;
    }
    return false;
  }

  static bool strongPasswordValidator(String value) {
    RegExp strongPassRegExp = RegExp(AppValidationMessages.strongPassRegExp);
    return !strongPassRegExp.hasMatch(value);
  }

  static bool confirmPasswordValidator(
      String password, String confirmPassword) {
    return password != confirmPassword;
  }
}
