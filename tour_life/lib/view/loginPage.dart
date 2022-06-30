import 'package:flutter/material.dart';
import 'package:tour_life/constant/strings.dart';

import '../constant/colorses.dart';

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
      body: Container(
        color: Colorses.red,
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
                        style: TextStyle(color: Colorses.white, fontSize: 40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Ready",
                                style: TextStyle(
                                    color: Colorses.white, fontSize: 40),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Saving managers ',
                                  style: TextStyle(fontSize: 20),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'time',
                                        style: TextStyle(color: Colorses.red)),
                                    TextSpan(text: ' &\n'),
                                    TextSpan(text: 'artists '),
                                    TextSpan(
                                        text: 'money.',
                                        style: TextStyle(color: Colorses.red)),
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
                          Container(
                            width: size.width / 1.3,
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: Colorses.white,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      contentPadding: EdgeInsets.all(20.0),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colorses.white),
                                      hintText: "Enter Email",
                                      fillColor: Colorses.red),
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colorses.white),
                                ),
                                SizedBox(
                                  height: size.height * 0.020,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colorses.white,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      contentPadding: EdgeInsets.all(20.0),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colorses.white),
                                      hintText: "Enter Password",
                                      fillColor: Colorses.red),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: TextStyle(color: Colorses.white),
                                )
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
            Container(
              color: Colorses.red,
            )
          ],
        ),
      ),
    );
  }
}
