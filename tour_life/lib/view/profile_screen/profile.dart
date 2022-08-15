import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/constant/images.dart';

import '../../constant/colorses.dart';
import '../../constant/date_time.dart';
import '../../constant/preferences_key.dart';
import '../../constant/strings.dart';
import '../../model/all_data_model.dart';
import '../../model/auth_model/login_model.dart';
import '../../provider/all_provider.dart';
import '../../widget/cicualer_indicator.dart';
import '../../widget/commanBtn.dart';
import '../auth/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  AllDataProvider allDataProvider = AllDataProvider();
  late AllDataModel prefData;
  List<Gigs> gigs = [];

  late LoginModel loginData;
  late Timer timer;
  String? lastsyncTime;
  String? lastTime;
  String? selectedUserId;
  List pastdateList = [];
  List upComingdateList = [];
  List totalFlightList = [];
  List<Schedule>? scheduleList = [];

  @override
  void initState() {
    allDataProvider = Provider.of<AllDataProvider>(context, listen: false);

    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));
    scheduleList = prefData.result!.schedule;
    var logindata = preferences.getString(Keys.loginReponse);
    loginData = LoginModel.fromJson(jsonDecode(logindata!));

    selectedUserId = preferences.getString(Keys.dropDownValue);

    isSwitched = preferences.getBool(Keys.toggalValue) ?? false;
    lastsyncTime = preferences.getString(Keys.lastsyncTime) ?? "0";

    if (loginData.result!.isManager!) {
      if (preferences.getBool(Keys.ismanagerValue) == null ||
          preferences.getBool(Keys.ismanagerValue)!) {
      } else {
        for (int i = 0; i < prefData.result!.gigs!.length; i++) {
          if (selectedUserId!
              .contains(prefData.result!.gigs![i].user.toString())) {
            gigs.add(prefData.result!.gigs![i]);
          }
        }
      }
    } else {
      for (int i = 0; i < prefData.result!.gigs!.length; i++) {
        if (loginData.result!.id
            .toString()
            .contains(prefData.result!.gigs![i].user.toString())) {
          gigs.add(prefData.result!.gigs![i]);
        }
      }
    }

    //total flight completed
    if (loginData.result!.isManager!) {
      if (preferences.getBool(Keys.ismanagerValue) == null ||
          preferences.getBool(Keys.ismanagerValue)!) {
      } else {
        for (int i = 0; i < scheduleList!.length; i++) {
          if (selectedUserId
              .toString()
              .contains(prefData.result!.schedule![i].user.toString())) {
            if (scheduleList![i].type.toString().contains("flight")) {
              DateTime pastdate = DateTime.now().toUtc();
              DateTime pastdate1 =
                  DateTime.parse(scheduleList![i].arrivalTime.toString());
              if (pastdate.isAfter(pastdate1)) {
                totalFlightList.add(scheduleList![i].flightId);
              }
            }
          }
        }
      }
    } else {
      for (int i = 0; i < scheduleList!.length; i++) {
        if (loginData.result!.id
            .toString()
            .contains(prefData.result!.schedule![i].user.toString())) {
          if (scheduleList![i].type.toString().contains("flight")) {
            DateTime pastdate = DateTime.now().toUtc();
            DateTime pastdate1 =
                DateTime.parse(scheduleList![i].arrivalTime.toString());
            if (pastdate.isAfter(pastdate1)) {
              totalFlightList.add(scheduleList![i].flightId);
            }
          }
        }
      }
    }
    print(totalFlightList.length);
    for (int i = 0; i < gigs.length; i++) {
      DateTime pastdate = DateTime.now().toUtc();
      DateTime pastdate1 = DateTime.parse(gigs[i].endDate!);
      if (pastdate.isAfter(pastdate1)) {
        pastdateList.add(1);
      } else if (pastdate.isBefore(pastdate1)) {
        upComingdateList.add(1);
      }
    }
    print(gigs);
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
        buildHeader(size: size),
        SizedBox(
          height: size.height * 0.020,
        ),
        SizedBox(
          width: 110,
          height: 110,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: gigs.isEmpty
                  ? Image.asset(Images.defaultImage)
                  : Image.network(
                      gigs[0].profilePic!,
                      fit: BoxFit.fill,
                    )),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          loginData.result!.firstName!,
          style: TextStyle(
              fontFamily: "Inter-Medium", fontSize: 18, color: Colorses.white),
        ),
        SizedBox(
          height: size.height * 0.004,
        ),
        Text(
          preferences.getString(Keys.emailValue)!,
          style: const TextStyle(fontFamily: "Inter-Medium", fontSize: 15),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.topCenter,
            height: 20,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colorses.black,
            ),
            child: Text(
              "Shows",
              style: TextStyle(
                  color: Colorses.white,
                  fontFamily: 'Inter-Medium',
                  fontSize: 14),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colorses.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Past Shows",
                      style:
                          TextStyle(fontFamily: "Inter-Medium", fontSize: 14),
                    ),
                    Text(
                      gigs.isEmpty ? "0" : pastdateList.length.toString(),
                      style: const TextStyle(
                          fontFamily: "Inter-Medium", fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  Images.whiteMicImage,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colorses.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Upcoming Shows",
                      style:
                          TextStyle(fontFamily: "Inter-Medium", fontSize: 14),
                    ),
                    Text(
                      gigs.isEmpty ? "0" : upComingdateList.length.toString(),
                      style: const TextStyle(
                          fontFamily: "Inter-Medium", fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.topCenter,
            height: 20,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colorses.black,
            ),
            child: Text(
              "Flight",
              style: TextStyle(
                  color: Colorses.white,
                  fontFamily: 'Inter-Medium',
                  fontSize: 14),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.asset(
                Images.whitePlaneImage,
              ),
            ),
            Container(
              width: size.width / 1.4,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colorses.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Total Completed",
                    style: TextStyle(fontFamily: "Inter-Medium", fontSize: 14),
                  ),
                  Text(
                    totalFlightList.isEmpty
                        ? "0"
                        : totalFlightList.length.toString(),
                    style: const TextStyle(
                        fontFamily: "Inter-Medium", fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        commanViewLine(size: size),
        SizedBox(
          height: size.height * 0.01,
        ),
        buildSyncNowPart(size: size),
        SizedBox(
          height: size.height * 0.02,
        ),
        commanViewLine(size: size),
      ],
    );
  }

  Widget buildHeader({Size? size}) {
    return Container(
        padding: EdgeInsets.only(top: size!.height * 0.05),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: Colorses.black,
        ),
        width: size.width,
        height: size.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "            ",
              style: TextStyle(
                  color: Colorses.white,
                  fontFamily: 'Inter-Bold',
                  fontSize: 20),
            ),
            Text(
              Strings.profileStr,
              style: TextStyle(
                  color: Colorses.white,
                  fontFamily: 'Inter-Bold',
                  fontSize: 20),
            ),
            InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colorses.red,
                  ),
                  Text(
                    Strings.logOutStr,
                    style: TextStyle(
                        color: Colorses.white,
                        fontFamily: 'Inter-Medium',
                        fontSize: 14),
                  )
                ],
              ),
              onTap: () {
                showModalSheet();
              },
            )
          ],
        ));
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
    return SizedBox(
      width: size!.width / 1.2,
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
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
                width: 75.0,
                height: 40.0,
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
