import 'package:flutter/material.dart';
import 'package:tour_life/constant/strings.dart';

import '../constant/colorses.dart';
import '../widget/commanTextField.dart';
import 'HomePage.dart';

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
      body: SingleChildScrollView(
        child: Container(
          color: Colorses.red,
          height: size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      color: Colorses.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colorses.black.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 5.0,
                          // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: size.width,
                    height: size.height / 1.2,
                  ),
                  SizedBox(
                    height: size.height / 1.2,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  "Ready",
                                  style: TextStyle(
                                      color: Colorses.white,
                                      fontFamily: 'Inter-Regular',
                                      fontSize: 40),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Saving managers ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Inter-SemiBold'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'time',
                                          style:
                                              TextStyle(color: Colorses.red)),
                                      TextSpan(text: ' &\n'),
                                      TextSpan(text: 'artists '),
                                      TextSpan(
                                          text: 'money.',
                                          style:
                                              TextStyle(color: Colorses.red)),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
                  )
                ],
              ),
              Expanded(
                child: buildLogInBtn(),
              )
            ],
          ),
        ),
      ),
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
