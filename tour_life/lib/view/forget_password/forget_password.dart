import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/constant/images.dart';

import '../../constant/colorses.dart';
import '../../constant/strings.dart';
import '../../provider/forget_provider.dart';
import '../../widget/commanBtn.dart';
import '../../widget/commanTextField.dart';
import 'reset_password/reset_password.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  TextEditingController emailController = TextEditingController();
  ForgetProvider forgetProvider = ForgetProvider();

  @override
  void initState() {
    forgetProvider = Provider.of<ForgetProvider>(context, listen: false);
    super.initState();
  }

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
    return SizedBox(
      width: size!.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40, child: Image.asset(Images.splashLogoImage)),
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
                    Strings.forgotPasswordSubStr,
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 14,
                        fontFamily: 'Inter-Medium'),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Image.asset(Images.securityImage),
          ),
          buildEmailField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CommanBtn(
                    text: Strings.resetPasswordStr,
                    bgColor: Colorses.red,
                    txtColor: Colorses.white,
                    onTap: () {
                      forgetProvider.alldatasProvider().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()),
                        );
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommanBtn(
                    text: Strings.backToLoginStr,
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
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CommanTextField(
        suffixIcon: Icon(
          Icons.person,
          color: Colorses.red,
        ),
        hintText: Strings.enterEmailStr,
        validator: (val) => !val!.contains('@') ? Strings.emalValidation : null,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
      ),
    );
  }
}
