import 'package:flutter/material.dart';

import '../api_provider/login_api_provider.dart';
import '../model/login_model.dart';
import '../user_model.dart';

class LoginProvider extends ChangeNotifier {
  LoginApiProvider loginProvide = LoginApiProvider();
  LoginModel? loginModel;

  Future<ApiResponseModel<LoginModel>> loginProvider({
    required String email,
    required String password,
  }) async {
    final loginModel = await loginProvide.loginApiProvider(
      email: email,
      password: password,
    );
    notifyListeners();
    return loginModel;
  }
}
