import 'package:flutter/material.dart';
import '../api_services/otp_api_provider.dart';
import '../model/otp_model.dart';

class OtpProvider extends ChangeNotifier {
  OtpApiProvider otpApiProvider = OtpApiProvider();
  OtpModel? otpModel;

  Future<OtpModel?> otpProvider(
      {required String email, required int opt}) async {
    otpModel = await otpApiProvider.otpApiProvider(email: email, opt: opt);
    notifyListeners();
    return otpModel;
  }
}
