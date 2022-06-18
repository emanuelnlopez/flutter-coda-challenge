class Validator {
  static const _validEmailRegExp =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const invalidEmailError = 'Invalid email';
  static const passwordLengthError =
      'Password should be at least 8 characters long';
  static const passwordMismatchError = 'Passwords do not match';
  static const requiredFieldError = 'Required field';

  static String? validateEmail(String? email) {
    String? result;
    if (email?.isNotEmpty != true) {
      result = requiredFieldError;
    }
    if (email?.isNotEmpty == true &&
        !RegExp(_validEmailRegExp).hasMatch(email!)) {
      result = invalidEmailError;
    }
    return result;
  }

  static String? validatePassword(String? password) {
    String? result;
    if (password?.isNotEmpty != true) {
      result = requiredFieldError;
    }
    if (password?.isNotEmpty == true && password!.length < 8) {
      result = passwordLengthError;
    }
    return result;
  }

  static String? validateRepeatPassword(
    String? repeatPassword, {
    String? password,
  }) {
    String? result;
    if (repeatPassword?.isNotEmpty != true) {
      result = requiredFieldError;
    }
    if (repeatPassword?.isNotEmpty == true && repeatPassword!.length < 8) {
      result = passwordLengthError;
    }
    if (repeatPassword?.isNotEmpty == true &&
        repeatPassword!.length >= 8 &&
        repeatPassword != password) {
      result = passwordMismatchError;
    }
    return result;
  }
}
