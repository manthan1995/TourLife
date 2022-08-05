import 'package:flutter/material.dart';

import '../../../../constant/colorses.dart';
import '../../../../constant/images.dart';
import '../../../../constant/strings.dart';
import '../../../../widget/commanBtn.dart';
import '../../../../widget/commanTextField.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({Key? key}) : super(key: key);

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  bool _passwordVisible = false;
  bool _confromVisible = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confrimPasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
    _confromVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colorses.black,
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 40, child: Image.asset(Images.splashLogoImage)),
                Column(
                  children: [
                    Text(
                      Strings.setNewPassStr,
                      style: TextStyle(
                          color: Colorses.white,
                          fontSize: 35,
                          fontFamily: 'Inter-Medium'),
                    ),
                    Text(
                      Strings.setNewPassSubStr,
                      style: TextStyle(
                          color: Colorses.white,
                          fontSize: 14,
                          fontFamily: 'Inter-Medium'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom: 5),
                        child: Text(
                          Strings.newPasswordStr,
                          style: TextStyle(
                              color: Colorses.white,
                              fontSize: 14,
                              fontFamily: 'Inter-Medium'),
                        ),
                      ),
                      buildPasswordField(),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom: 5),
                        child: Text(
                          Strings.confirmNewPasswordStr,
                          style: TextStyle(
                              color: Colorses.white,
                              fontSize: 14,
                              fontFamily: 'Inter-Medium'),
                        ),
                      ),
                      buildConfrimPasswordField()
                    ],
                  ),
                ),
                Column(
                  children: [
                    CommanBtn(
                      text: Strings.submitPasswordStr,
                      bgColor: Colorses.red,
                      txtColor: Colorses.white,
                      onTap: () {
                        _form.currentState!.validate();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return CommanTextField(
      suffixIcon: IconButton(
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colorses.red,
        ),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
      hintText: Strings.enterPasswordStr,
      obscureText: !_passwordVisible,
      keyboardType: TextInputType.text,
      validator: (val) => val!.isEmpty ? Strings.passwordValidation : null,
      controller: passwordController,
    );
  }

  Widget buildConfrimPasswordField() {
    return CommanTextField(
      suffixIcon: IconButton(
        icon: Icon(
          _confromVisible ? Icons.visibility : Icons.visibility_off,
          color: Colorses.red,
        ),
        onPressed: () {
          setState(() {
            _confromVisible = !_confromVisible;
          });
        },
      ),
      hintText: Strings.enterConfirmPasswordStr,
      obscureText: !_confromVisible,
      keyboardType: TextInputType.text,
      validator: (val) {
        if (val!.isEmpty) {
          return Strings.passwordValidation;
        }
        if (val != passwordController.text) {
          return 'Not Match';
        }
        return null;
      },
      controller: confrimPasswordController,
    );
  }
}
