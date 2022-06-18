class Validator {
  static const _validEmailRegExp =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String? validateEmail(String? email) {
    String? result;
    if (email?.isNotEmpty != true) {
      result = 'Required value';
    }
    if (email?.isNotEmpty == true &&
        !RegExp(_validEmailRegExp).hasMatch(email!)) {
      result = 'Invalid email';
    }
    return result;
  }

  static String? validatePassword(String? password) {
    String? result;
    if (password?.isNotEmpty != true) {
      result = 'Required value';
    }
    if (password?.isNotEmpty == true && password!.length < 8) {
      result = 'Password should be at least 8 characters long';
    }
    return result;
  }

  static String? validateRepeatPassword(
    String? repeatPassword, {
    String? password,
  }) {
    String? result;
    if (repeatPassword?.isNotEmpty != true) {
      result = 'Required value';
    }
    if (repeatPassword?.isNotEmpty == true && repeatPassword!.length < 8) {
      result = 'Password should be at least 8 characters long';
    }
    if (repeatPassword?.isNotEmpty == true &&
        repeatPassword!.length >= 8 &&
        repeatPassword != password) {
      result = 'Passwords do not match';
    }
    return result;
  }
}
