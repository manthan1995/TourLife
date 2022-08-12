import 'package:shared_preferences/shared_preferences.dart';

class Keys {
  static const String loginReponse = 'loginResponse';
  static const String allReponse = 'allResponse';
  static const String forgetReponse = 'forgetResponse';
  static const String otpReponse = 'otpReponse';
  static const String dropDownValue = 'dropDownValue';
  static const String setPassValue = 'setPassValue';
  static const String userValue = 'userValue';
  static const String tokenValue = 'token';
  static const String emailValue = 'email';
  static const String ismanagerValue = 'ismanager';
  static const String isResetpass = 'isResetpass';
  static const String toggalValue = 'toggalValue';
  static const String lastsyncTime = 'lastsyncTime';
  static const String lastTime = 'lastTime';
}

late SharedPreferences preferences;
late SharedPreferences pref;
