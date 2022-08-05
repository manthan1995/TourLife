import 'dart:convert';

import '../constant/api.dart';
import '../constant/preferences_key.dart';
import '../model/foreget_pass_model.dart';
import 'package:http/http.dart' as http;

class ForgetApiProvider {
  late Map<String, dynamic> pref;

  Future<ForgetPassModel> fogetPassApiProvider() async {
    Map map = <String, dynamic>{};
    map['email'] = preferences.getString(Keys.emailValue)!;
    final response = await http.post(
        Uri.parse(ApiUrls.baseUrl + ApiUrls.forgotPasswordUrl),
        body: map);
    if (response.statusCode == 200) {
      final fogetBody = ForgetPassModel.fromJson(json.decode(response.body));
      final bodyToMap = fogetBody.toJson();

      await preferences.setString(Keys.forgetReponse, jsonEncode(bodyToMap));
      return ForgetPassModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
