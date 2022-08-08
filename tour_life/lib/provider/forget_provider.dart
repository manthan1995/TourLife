import 'package:flutter/material.dart';

import '../api_services/forget_api_provider.dart';
import '../model/foreget_pass_model.dart';

class ForgetProvider extends ChangeNotifier {
  ForgetApiProvider forgetApiProvider = ForgetApiProvider();
  ForgetPassModel? forgetPassModel;

  Future<ForgetPassModel?> forgetProvider({required String email}) async {
    forgetPassModel =
        await forgetApiProvider.fogetPassApiProvider(email: email);
    notifyListeners();
    return forgetPassModel;
  }
}
