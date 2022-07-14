import 'dart:convert';

import 'package:tour_life/constant/api.dart';

import '../../../constant/preferences_key.dart';
import '../../auth/user_model.dart';
import '../model/all_data_model.dart';
import 'package:http/http.dart' as http;

class AllDataApiProvider {
  Future<AllDataModel> allDataApiProvider() async {
    final response = await http.get(
        Uri.parse("http://192.168.29.102:3000/all_data"),
        headers: {"Authorization": ApiUrls.token});
    if (response.statusCode == 200) {
      final allDataBody = AllDataModel.fromJson(json.decode(response.body));
      final bodyToMap = allDataBody.toJson();
      //print(bodyToMap);

      await preferences.setString(Keys.allReponse, jsonEncode(bodyToMap));
      return AllDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
