import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/preferences_key.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/cicualer_indicator.dart';

import '../../constant/date_time.dart';
import '../../model/auth_model/login_model.dart';
import '../../widget/commanBtn.dart';
import '../../widget/commanHeader.dart';
import '../../provider/all_provider.dart';
import '../auth/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  AllDataProvider allDataProvider = AllDataProvider();
  late LoginModel loginData;
  late Timer timer;
  String? lastsyncTime;
  String? lastTime;

  @override
  void initState() {
    allDataProvider = Provider.of<AllDataProvider>(context, listen: false);
    var logindata = preferences.getString(Keys.loginReponse);
    loginData = LoginModel.fromJson(jsonDecode(logindata!));
    isSwitched = preferences.getBool(Keys.toggalValue) ?? false;
    lastsyncTime = preferences.getString(Keys.lastsyncTime) ?? "0";

    super.initState();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;

        preferences.setBool(Keys.toggalValue, true);
        preferences.setString(Keys.lastsyncTime,
            getTime(times: DateTime.now().toUtc().toString()));
        timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
          if (isSwitched) {
            allDataProvider.alldatasProvider();
            preferences.setString(
                Keys.lastTime, DateTime.now().toUtc().toString());
          } else {
            timer.cancel();
          }
        });
        lastsyncTime = getTime(times: DateTime.now().toUtc().toString());
      });
    } else {
      setState(() {
        isSwitched = false;
        preferences.setBool(Keys.toggalValue, false);
      });
    }
  }

  void showModalSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colorses.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const SizedBox(
                      width: 70,
                      height: 7,
                      child: Text(
                        "",
                      )),
                ),
                const Text(
                  Strings.logOutStr,
                  style: TextStyle(fontSize: 25, fontFamily: "Inter-Bold"),
                ),
                const Text(
                  "Are you sure you want to leave?",
                  style: TextStyle(fontSize: 18, fontFamily: "Inter-Medium"),
                ),
                CommanBtn(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3.5,
                      vertical: 15),
                  text: Strings.yesStr,
                  bgColor: Colorses.red,
                  txtColor: Colorses.white,
                  onTap: () {
                    preferences.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                    preferences.setBool(Keys.isResetpass, false);
                  },
                ),
                CommanBtn(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3.5,
                      vertical: 15),
                  text: Strings.noStr,
                  bgColor: Colorses.black,
                  txtColor: Colorses.white,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorses.red,
      body: buildMainPart(),
    );
  }

  Widget buildMainPart() {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        buildHeader(),
        SizedBox(
          height: size.height * 0.030,
        ),
        buildLogOutPart(size: size),
        SizedBox(
          height: size.height * 0.025,
        ),
        commanViewLine(size: size),
        SizedBox(
          height: size.height * 0.025,
        ),
        buildCopyPart(size: size),
        SizedBox(
          height: size.height * 0.025,
        ),
        commanViewLine(size: size),
        SizedBox(
          height: size.height * 0.025,
        ),
        buildSyncNowPart(size: size),
        SizedBox(
          height: size.height * 0.025,
        ),
        commanViewLine(size: size),
        SizedBox(
          height: size.height * 0.025,
        ),
        Text(
          Strings.appVersionStr,
          style: TextStyle(
            color: Colorses.white,
            fontFamily: 'Inter-Regular',
          ),
        )
      ],
    );
  }

  Widget buildHeader() {
    return const CommanHeader(
      text: Strings.profileStr,
    );
  }

  Widget buildLogOutPart({Size? size}) {
    return Column(
      children: [
        Text(
          Strings.loggedInAsStr,
          style: TextStyle(
            color: Colorses.white,
            fontFamily: 'Inter-Regular',
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: size!.height * 0.010,
        ),
        Text(
          preferences.getString(Keys.emailValue)!,
          style: const TextStyle(fontSize: 18, fontFamily: 'Inter-Medium'),
        ),
        SizedBox(
          height: size.height * 0.010,
        ),
        CommanBtn(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          text: Strings.logOutStr,
          bgColor: Colorses.white,
          txtColor: Colorses.red,
          onTap: () {
            showModalSheet();
          },
        ),
      ],
    );
  }

  Widget buildCopyPart({Size? size}) {
    return Column(
      children: [
        Text(
          Strings.iCalLinkStr,
          style: TextStyle(
            color: Colorses.white,
            fontFamily: 'Inter-Regular',
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: size!.height * 0.010,
        ),
        const Text(
          Strings.iCalLinkUrl,
          style: TextStyle(fontSize: 15, fontFamily: 'Inter-Medium'),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.010,
        ),
        CommanBtn(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          text: Strings.copyStr,
          bgColor: Colorses.white,
          txtColor: Colorses.red,
        ),
      ],
    );
  }

  Widget buildSyncNowPart({Size? size}) {
    DateTime currentTime = DateTime.now().toUtc();
    DateTime currentDate;
    int? agoMinit;
    int? agoHours;
    lastTime = preferences.getString(Keys.lastTime) ?? "";
    if (lastTime == "") {
      agoMinit = 00;
      agoHours = 00;
    } else {
      currentDate = DateTime.parse(lastTime!);
      agoHours = currentTime.difference(currentDate).inHours;
      agoMinit = currentTime.difference(currentDate).inMinutes % 60;
    }

    print(agoMinit);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size!.width * 0.04),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    Strings.lastSyncedStr,
                    style: TextStyle(
                      color: Colorses.white,
                      fontFamily: 'Inter-Regular',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    lastsyncTime!,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Inter-Medium',
                      color: Colorses.white,
                    ),
                  ),
                  Text(
                    "${agoHours == 0 || agoHours < 0 ? "" : "$agoHours hours ago"} ${agoHours < 0 ? "" : (agoMinit == 0 ? "Just now" : "$agoMinit minutes ago")}",
                    style: TextStyle(
                      fontFamily: 'Inter-Light',
                      color: Colorses.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.010,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommanBtn(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                text: Strings.syncNowStr,
                bgColor: Colorses.white,
                txtColor: Colorses.red,
                onTap: () {
                  showLoader(context: context);
                  allDataProvider.alldatasProvider().then((_) {
                    hideLoader(context: context);
                    Fluttertoast.showToast(
                        msg: "Sync successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  });
                },
              ),
              FlutterSwitch(
                width: 80.0,
                height: 45.0,
                toggleSize: 45.0,
                value: isSwitched,
                borderRadius: 30.0,
                padding: 2.0,
                toggleColor: Colorses.white,
                switchBorder: Border.all(
                  color: Colorses.white,
                  width: 3.0,
                ),
                toggleBorder: Border.all(
                  color: Colorses.white,
                  width: 3.0,
                ),
                activeColor: const Color.fromARGB(108, 255, 255, 255),
                inactiveColor: Colorses.red,
                onToggle: toggleSwitch,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commanViewLine({Size? size}) {
    return Container(
      width: size!.width / 1.2,
      height: 1,
      color: Colorses.black,
    );
  }
}
