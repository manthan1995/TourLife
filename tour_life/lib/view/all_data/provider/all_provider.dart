import 'package:flutter/material.dart';
import 'package:tour_life/view/all_data/model/all_data_model.dart';

import '../api_provider/all_api_provider.dart';

class AllDataProvider extends ChangeNotifier {
  AllDataApiProvider allDataApiProvider = AllDataApiProvider();
  AllDataModel? allDataModel;

  Future<AllDataModel?> alldatasProvider() async {
    allDataModel = await allDataApiProvider.allDataApiProvider();
    notifyListeners();
    return allDataModel;
  }
}
