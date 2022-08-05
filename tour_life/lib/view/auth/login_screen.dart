import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/constant/strings.dart';

import '../../constant/colorses.dart';
import '../../constant/images.dart';
import '../../constant/preferences_key.dart';
import '../../widget/cicualer_indicator.dart';
import '../../widget/commanTextField.dart';
import '../../provider/all_provider.dart';
import '../forget_password/forget_password.dart';
import '../bottom_bar/home_screen.dart';
import '../../model/auth_model/login_model.dart';
import '../../provider/auth/login_provider.dart';
import '../../model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginProvider loginProvider = LoginProvider();
  AllDataProvider allDataProvider = AllDataProvider();
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  Image? imagebg;

  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    allDataProvider = Provider.of<AllDataProvider>(context, listen: false);
    _passwordVisible = false;

    super.initState();
    imagebg = Image.asset(Images.loginbgImage);
  }

  @override
  void didChangeDependencies() {
    precacheImage(imagebg!.image, context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(child: buildMainView(size: size)),
    );
  }

  Widget buildMainView({Size? size}) {
    return Form(
      key: formKey,
      child: Container(
          color: Colorses.red,
          height: size!.height,
          child: Consumer<LoginProvider>(
            builder: (context, valueOfLogin, child) => Column(
              children: [
                Stack(
                  children: [
                    buildBackground(size: size),
                    buildForGround(size: size),
                  ],
                ),
                Expanded(
                  child: buildLogInBtn(loginProvider: loginProvider),
                )
              ],
            ),
          )),
    );
  }

  Widget buildBackground({Size? size}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        color: Colorses.black,
      ),
      width: size!.width,
      height: size.height / 1.15,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Image.asset(Images.splasbgImage),
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
          Expanded(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.center,
                  child: buildTitle())),
          // buildSubTitle(),
          Expanded(
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Image.asset(
      Images.splashLogoImage,
      fit: BoxFit.fill,
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
                style:
                    const TextStyle(fontSize: 20, fontFamily: 'Inter-SemiBold'),
                children: <TextSpan>[
                  TextSpan(
                      text: Strings.timeTxt,
                      style: TextStyle(color: Colorses.red)),
                  const TextSpan(text: ' &\n'),
                  const TextSpan(text: Strings.artistsStr),
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
        color: Colorses.red,
      ),
      hintText: Strings.enterEmailStr,
      validator: (val) => !val!.contains('@') ? Strings.emalValidation : null,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
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

  Widget buildLogInBtn({
    required LoginProvider loginProvider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            bool result = await InternetConnectionChecker().hasConnection;
            if (result == true) {
              if (formKey.currentState!.validate()) {
                showLoader(context: context);
                final ApiResponseModel<LoginModel> loginResponse =
                    await loginProvider.loginProvider(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                if (loginResponse.error == false) {
                  hideLoader(context: context);
                  preferences.setString(Keys.tokenValue,
                      'token ${loginResponse.data!.result!.token.toString()}');
                  preferences.setString(
                      Keys.emailValue, emailController.text.trim());

                  allDataProvider.allDataApiProvider
                      .allDataApiProvider()
                      .then((value) {
                    setState(() {
                      var data = preferences.getString(Keys.allReponse);
                      if (data != null) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false);
                      }
                    });
                  });
                } else {
                  hideLoader(context: context);
                  Fluttertoast.showToast(
                      msg: loginResponse.data!.message.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16.0);
                }
              }
            } else {
              Fluttertoast.showToast(
                  msg: "Please, Check internet connection",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
            }
          },
          child: Text(
            Strings.logInStr,
            style: TextStyle(
                color: Colorses.white,
                fontSize: 22,
                fontFamily: 'Inter-Medium'),
          ),
        ),
        const SizedBox(
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgetPassScreen()),
        );
      },
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
