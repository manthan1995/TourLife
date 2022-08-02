import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_life/constant/date_time.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:tour_life/widget/commanHeaderBg.dart';

import '../constant/colorses.dart';
import '../constant/preferences_key.dart';
import 'all_data/model/all_data_model.dart';
import 'auth/model/login_model.dart';

class RunningOrder extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  RunningOrder(
      {Key? key,
      required this.userName,
      required this.date,
      required this.month,
      required this.location,
      required this.coverPic,
      required this.profilePic,
      required this.gigId})
      : super(key: key);

  @override
  _RunningOrderState createState() => _RunningOrderState();
}

class _RunningOrderState extends State<RunningOrder> {
  late AllDataModel prefData;
  late LoginModel loginData;
  String? selectedUserId;
  List username = [];
  List<Gigs> gigs = [];

  @override
  void initState() {
    // TODO: implement initState
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));

    var logindata = preferences.getString(Keys.loginReponse);
    loginData = LoginModel.fromJson(jsonDecode(logindata!));

    selectedUserId = preferences.getString(Keys.dropDownValue);

    if (loginData.result!.isManager!) {
      if (preferences.getBool(Keys.ismanagerValue) == null ||
          preferences.getBool(Keys.ismanagerValue)!) {
        for (int i = 0; i < prefData.result!.gigs!.length; i++) {
          if (widget.gigId == prefData.result!.gigs![i].id) {
            gigs.add(prefData.result!.gigs![i]);
          }
        }
      } else {
        for (int i = 0; i < prefData.result!.gigs!.length; i++) {
          if (selectedUserId!
                  .contains(prefData.result!.gigs![i].user.toString()) &&
              widget.gigId == prefData.result!.gigs![i].id) {
            gigs.add(prefData.result!.gigs![i]);
          }
        }
      }
    } else {
      for (int i = 0; i < prefData.result!.gigs!.length; i++) {
        if (loginData.result!.id
                .toString()
                .contains(prefData.result!.gigs![i].user.toString()) &&
            widget.gigId == prefData.result!.gigs![i].id) {
          gigs.add(prefData.result!.gigs![i]);
        }
      }
    }

    for (int i = 0; i < gigs.length; i++) {
      if (gigs[i].user == prefData.result!.users![gigs[i].user! - 1].id) {
        username.add(prefData.result!.users![gigs[i].user! - 1].firstName);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colorses.red,
      appBar: buildAppbar(
        context: context,
        text: Strings.runningOrderStr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CommanHeaderBg(
                  title: widget.userName,
                  subTitle: widget.location,
                  date: widget.date,
                  profilePic: widget.profilePic,
                  coverPic: widget.coverPic,
                  month: widget.month,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.height * 0.01,
                    right: size.height * 0.01,
                    top: size.height * 0.15,
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: gigs.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildListItem(size: size, index: index),
                            );
                          })),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListItem({Size? size, int? index}) {
    DateTime currentTime = DateTime.now();
    DateTime currentDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'")
        .parse(currentTime.toUtc().toString());

    String start = getFullDate(fullDates: gigs[index!].startDate);
    DateTime startDate = DateFormat.yMd().add_jm().parse(start);
    String end = getFullDate(fullDates: gigs[index].endDate);
    DateTime endDate = DateFormat.yMd().add_jm().parse(end);
    print("====>$startDate");
    print("<===$endDate");
    print("-----------$currentDate");

    if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
      print("object");
    }
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        color: Colorses.white,
      ),
      width: size!.width * 0.8,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    color: Colorses.black,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "${getTime(times: gigs[index].startDate)} to ${getTime(times: gigs[index].endDate)}",
                    style: TextStyle(
                        color: Colorses.white,
                        fontFamily: 'Inter-Medium',
                        fontSize: 15),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username[index],
                      style: TextStyle(
                          color: Colorses.red,
                          fontFamily: 'Inter-Medium',
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ],
          ),
          currentDate.isAfter(startDate) && currentDate.isBefore(endDate)
              ? Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(1),
                  margin: EdgeInsets.only(right: 20),
                  child: Container(
                    width: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colorses.green),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
