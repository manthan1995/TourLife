import 'package:flutter/material.dart';

import '../../api_services/auth/login_api_provider.dart';
import '../../model/auth_model/login_model.dart';
import '../../model/user_model.dart';

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
