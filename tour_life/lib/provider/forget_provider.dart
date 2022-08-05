import 'package:flutter/material.dart';

import '../api_services/forget_api_provider.dart';
import '../model/foreget_pass_model.dart';

class ForgetProvider extends ChangeNotifier {
  ForgetApiProvider forgetApiProvider = ForgetApiProvider();
  ForgetPassModel? forgetPassModel;

  Future<ForgetPassModel?> alldatasProvider() async {
    forgetPassModel = await forgetApiProvider.fogetPassApiProvider();
    notifyListeners();
    return forgetPassModel;
  }
}
