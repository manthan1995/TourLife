import 'dart:convert';

import '../constant/api.dart';
import 'package:http/http.dart' as http;

import '../constant/preferences_key.dart';
import '../model/otp_model.dart';

class OtpApiProvider {
  late Map<String, dynamic> pref;

  Future<OtpModel> otpApiProvider(
      {required String email, required int opt}) async {
    Map map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = opt.toString();
    final response =
        await http.post(Uri.parse(ApiUrls.baseUrl + ApiUrls.otpUrl), body: map);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final otpBody = OtpModel.fromJson(json.decode(response.body));
      final bodyToMap = otpBody.toJson();

      await preferences.setString(Keys.otpReponse, jsonEncode(bodyToMap));
      return OtpModel.fromJson(json.decode(response.body));
    } else {
      return OtpModel.fromJson(json.decode(response.body));
    }
  }
}
