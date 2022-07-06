import 'package:flutter/material.dart';
import 'package:tour_life/constant/strings.dart';

import '../../../constant/colorses.dart';
import '../../../constant/images.dart';
import '../../../widget/commanTextField.dart';
import '../../home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(child: buildMainView(size: size)),
    );
  }

  Widget buildMainView({Size? size}) {
    return Container(
      color: Colorses.red,
      height: size!.height,
      child: Column(
        children: [
          Stack(
            children: [
              buildBackground(size: size),
              buildForGround(size: size),
            ],
          ),
          Expanded(
            child: buildLogInBtn(),
          )
        ],
      ),
    );
  }

  Widget buildBackground({Size? size}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        color: Colorses.white,
        boxShadow: [
          BoxShadow(
            color: Colorses.black.withOpacity(0.2),
            blurRadius: 2.0,
            spreadRadius: 5.0,
            // shadow direction: bottom right
          )
        ],
      ),
      width: size!.width,
      height: size.height / 1.2,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: Image.asset(
          Images.loginbgImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildForGround({Size? size}) {
    return SizedBox(
      height: size!.height / 1.2,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTitle(),
          buildSubTitle(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width / 1.3,
                child: Column(
                  children: [
                    buildEmailField(),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    buildPasswordField(),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    buildForgetPassword(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      Strings.appNameStr,
      style: TextStyle(
        color: Colorses.white,
        fontSize: 40,
        fontFamily: 'Inter-Regular',
      ),
    );
  }

  Widget buildSubTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              Strings.readyStr,
              style: TextStyle(
                  color: Colorses.white,
                  fontFamily: 'Inter-Regular',
                  fontSize: 40),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: Strings.savingManagersStr,
                style: TextStyle(fontSize: 20, fontFamily: 'Inter-SemiBold'),
                children: <TextSpan>[
                  TextSpan(
                      text: Strings.timeTxt,
                      style: TextStyle(color: Colorses.red)),
                  TextSpan(text: ' &\n'),
                  TextSpan(text: Strings.artistsStr),
                  TextSpan(
                      text: Strings.moneyStr,
                      style: TextStyle(color: Colorses.red)),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildEmailField() {
    return CommanTextField(
      suffixIcon: Icon(
        Icons.person,
        color: Colorses.white,
      ),
      hintText: Strings.enterEmailStr,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildPasswordField() {
    return CommanTextField(
      suffixIcon: Icon(
        Icons.remove_red_eye_outlined,
        color: Colorses.white,
      ),
      hintText: Strings.enterPasswordStr,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildLogInBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Text(
            Strings.logInStr,
            style: TextStyle(
                color: Colorses.white,
                fontSize: 22,
                fontFamily: 'Inter-Medium'),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.arrow_forward,
          color: Colorses.white,
        )
      ],
    );
  }

  Widget buildForgetPassword() {
    return InkWell(
      child: Text(
        Strings.forgotPasswordStr,
        style: TextStyle(
          fontFamily: 'Inter-Medium',
          color: Colorses.white,
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
