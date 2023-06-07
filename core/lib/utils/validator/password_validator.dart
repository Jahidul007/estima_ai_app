import 'dart:async';

class PasswordValidator {
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.length >= 8) {
        if (validatePass(email)) {
          sink.add(email);
        } else {
          sink.addError(
              "Password must contain one caps. one lower case, one number and one special character(! @ # \$ & * ~)");
        }
      } else {
        sink.addError(
            "Password length must be 8 and must contain one caps. one lower case, one number and one special character(! @ # \$ & * ~)");
      }
    },
  );
}

/*if (!hasMinUppercase(email,1)) {
          sink.addError("Must contain one upper case(A-Z)");
        }
        if (!hasMinLowercase(email,1)) {
          sink.addError("Must contain one lower case(a-z)");
        }
        else if (!hasMinNumericChar(email,1)) {
          sink.addError("Must contain one numeric number(0-9)");
        }
        else if (!hasMinSpecialChar(email,1)) {
          sink.addError("Must contain one special character(! @ # \$ & * ~)");
        }*/

/// Checks if password has minLength
bool hasMinLength(String password, int minLength) {
  return password.length >= minLength ? true : false;
}

/// Checks if password has at least uppercaseCount uppercase letter matches
bool hasMinUppercase(String password, int uppercaseCount) {
  String pattern = '^(.*?[A-Z]){' + uppercaseCount.toString() + ',}';
  return password.contains(new RegExp(pattern));
}

/// Checks if password has at least uppercaseCount uppercase letter matches
bool hasMinLowercase(String password, int lowercaseCount) {
  String pattern = '^(.*?[a-z]){' + lowercaseCount.toString() + ',}';
  return password.contains(new RegExp(pattern));
}

/// Checks if password has at least numericCount numeric character matches
bool hasMinNumericChar(String password, int numericCount) {
  String pattern = '^(.*?[0-9]){' + numericCount.toString() + ',}';
  return password.contains(new RegExp(pattern));
}

//Checks if password has at least specialCount special character matches
bool hasMinSpecialChar(String password, int specialCount) {
  String pattern =
      r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){" + specialCount.toString() + ",}";
  return password.contains(new RegExp(pattern));
}

bool validatePass(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
