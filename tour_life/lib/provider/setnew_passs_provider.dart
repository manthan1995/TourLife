import 'package:flutter/material.dart';
import '../api_services/setpass_api_provider.dart';
import '../model/setNewPass_model.dart';

class SetPassProvider extends ChangeNotifier {
  SetPassApiProvider setPassApiProvider = SetPassApiProvider();
  SetNewPassModel? setNewPassModel;

  Future<SetNewPassModel?> setPassProvider(
      {required String email, required String newPass}) async {
    setNewPassModel = await setPassApiProvider.setPassApiProvider(
        email: email, newPass: newPass);
    notifyListeners();
    return setNewPassModel;
  }
}
