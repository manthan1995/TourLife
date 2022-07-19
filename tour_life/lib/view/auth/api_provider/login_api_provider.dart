import 'dart:convert';

import '../../../constant/api.dart';
import '../../../constant/preferences_key.dart';
import '../model/login_model.dart';
import '../user_model.dart';
import 'package:http/http.dart' as http;

class LoginApiProvider {
  Future<ApiResponseModel<LoginModel>> loginApiProvider({
    required String email,
    required String password,
  }) async {
    Map map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;

    final response = await http.post(
      Uri.parse(ApiUrls.baseUrl + ApiUrls.loginUrl),
      body: map,
    );
    if (response.statusCode == 200) {
      final loginBody = LoginModel.fromJson(json.decode(response.body));
      final bodyToMap = loginBody.toJson();
      print(bodyToMap);

      await preferences.setString(Keys.loginReponse, jsonEncode(bodyToMap));
      return ApiResponseModel(
        error: false,
        data: LoginModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ApiResponseModel(
          error: true, data: LoginModel.fromJson(json.decode(response.body)));
    }
  }
}
