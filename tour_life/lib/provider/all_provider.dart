import 'package:flutter/material.dart';
import 'package:tour_life/model/all_data_model.dart';

import '../api_services/all_api_provider.dart';

class AllDataProvider extends ChangeNotifier {
  AllDataApiProvider allDataApiProvider = AllDataApiProvider();
  AllDataModel? allDataModel;

  Future<AllDataModel?> alldatasProvider() async {
    allDataModel = await allDataApiProvider.allDataApiProvider();
    notifyListeners();
    return allDataModel;
  }
}
