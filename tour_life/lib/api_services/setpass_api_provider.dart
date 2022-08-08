import 'dart:convert';

import '../constant/api.dart';
import 'package:http/http.dart' as http;

import '../constant/preferences_key.dart';
import '../model/setNewPass_model.dart';

class SetPassApiProvider {
  late Map<String, dynamic> pref;

  Future<SetNewPassModel> setPassApiProvider(
      {required String email, required String newPass}) async {
    Map map = <String, dynamic>{};
    map['email'] = email;
    map['new_password'] = newPass;
    final response = await http.post(
        Uri.parse(ApiUrls.baseUrl + ApiUrls.setNewPasswordUrl),
        body: map);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final setPassBody = SetNewPassModel.fromJson(json.decode(response.body));
      final bodyToMap = setPassBody.toJson();

      await preferences.setString(Keys.setPassValue, jsonEncode(bodyToMap));
      return SetNewPassModel.fromJson(json.decode(response.body));
    } else {
      return SetNewPassModel.fromJson(json.decode(response.body));
    }
  }
}
