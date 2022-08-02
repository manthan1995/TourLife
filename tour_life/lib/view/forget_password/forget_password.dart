import 'package:flutter/material.dart';
import 'package:tour_life/constant/images.dart';

import '../../constant/colorses.dart';
import '../../constant/strings.dart';
import '../../widget/commanBtn.dart';
import '../../widget/commanTextField.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colorses.black,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(child: buildMainView(size: size)),
    );
  }

  Widget buildMainView({Size? size}) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.appNameStr,
            style: TextStyle(
              color: Colorses.white,
              fontSize: 40,
              fontFamily: 'Inter-Regular',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    Strings.forgotPasswordStr,
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 35,
                        fontFamily: 'Inter-Medium'),
                  ),
                  Text(
                    "To reset your password, you need your email or",
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 14,
                        fontFamily: 'Inter-Medium'),
                  ),
                  Text(
                    "mobile number that can be authenticated",
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 14,
                        fontFamily: 'Inter-Medium'),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Image.asset(Images.securityImage),
          ),
          buildEmailField(),
          Row(
            children: [
              Column(
                children: [
                  CommanBtn(
                    text: "Reset Password",
                    bgColor: Colorses.red,
                    txtColor: Colorses.white,
                  ),
                  CommanBtn(
                    text: "  Back to Login  ",
                    bgColor: Colorses.grey,
                    txtColor: Colorses.white,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildEmailField() {
    return CommanTextField(
      suffixIcon: Icon(
        Icons.person,
        color: Colorses.red,
      ),
      hintText: Strings.enterEmailStr,
      validator: (val) => !val!.contains('@') ? Strings.emalValidation : null,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
    );
  }
}
