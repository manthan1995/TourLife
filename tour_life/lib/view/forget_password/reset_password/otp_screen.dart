import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/forget_password/reset_password/set_password/set_password_screen.dart';

import '../../../constant/images.dart';
import '../../../constant/preferences_key.dart';
import '../../../model/foreget_pass_model.dart';
import '../../../model/otp_model.dart';
import '../../../provider/otp_provider.dart';
import '../../../widget/cicualer_indicator.dart';
import '../../../widget/commanBtn.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpProvider otpProvider = OtpProvider();
  late ForgetPassModel forgetPassData;

  @override
  void initState() {
    otpProvider = Provider.of<OtpProvider>(context, listen: false);
    var forgetPassdata = preferences.getString(Keys.forgetReponse);
    forgetPassData = ForgetPassModel.fromJson(jsonDecode(forgetPassdata!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colorses.black,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 40, child: Image.asset(Images.splashLogoImage)),
              Column(
                children: [
                  Text(
                    Strings.verificationStr,
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 35,
                        fontFamily: 'Inter-Medium'),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: Strings.verificationSubStr,
                      style: TextStyle(
                          color: Colorses.white,
                          fontSize: 14,
                          fontFamily: 'Inter-Medium'),
                      children: <TextSpan>[
                        TextSpan(
                            text: Strings.tourLifeEmailStr,
                            style: TextStyle(color: Colorses.red)),
                      ],
                    ),
                  )
                ],
              ),
              OtpTextField(
                borderRadius: BorderRadius.circular(20),
                fieldWidth: 55,
                textStyle: TextStyle(color: Colorses.white),
                disabledBorderColor: Colorses.red,
                focusedBorderColor: Colorses.red,
                enabledBorderColor: Colorses.white,
                numberOfFields: 4,
                borderColor: Colorses.red,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {
                  showLoader(context: context);
                  print(verificationCode);
                  final OtpModel? otpdata = await otpProvider.otpProvider(
                      email: forgetPassData.results!.email!,
                      opt: int.parse(verificationCode));

                  if (otpdata!.error == false) {
                    hideLoader(context: context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetPassScreen()));
                  } else {
                    hideLoader(context: context);

                    Fluttertoast.showToast(
                        msg: otpdata.message.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  }
                },
              ),
              Column(
                children: [
                  CommanBtn(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    text: Strings.submitOtpStr,
                    bgColor: Colorses.red,
                    txtColor: Colorses.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetPassScreen()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: Strings.reSendOtpStr,
                      style: TextStyle(
                          color: Colorses.white,
                          fontSize: 14,
                          fontFamily: 'Inter-Medium'),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' 0:20',
                            style: TextStyle(color: Colorses.red)),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
