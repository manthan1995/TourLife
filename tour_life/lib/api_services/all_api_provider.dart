import 'dart:convert';

import 'package:tour_life/constant/api.dart';

import '../constant/preferences_key.dart';
import '../model/all_data_model.dart';
import 'package:http/http.dart' as http;

class AllDataApiProvider {
  late Map<String, dynamic> pref;

  Future<AllDataModel> allDataApiProvider() async {
    final response = await http
        .get(Uri.parse(ApiUrls.baseUrl + ApiUrls.allDataUrl), headers: {
      "Authorization": preferences.getString(Keys.tokenValue).toString()
    });
    if (response.statusCode == 200) {
      final allDataBody = AllDataModel.fromJson(json.decode(response.body));
      final bodyToMap = allDataBody.toJson();

      await preferences.setString(Keys.allReponse, jsonEncode(bodyToMap));
      return AllDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
