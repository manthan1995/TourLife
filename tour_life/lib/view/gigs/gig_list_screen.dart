import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/auth/model/login_model.dart';
import 'package:tour_life/widget/commanHeader.dart';

import '../../constant/date_time.dart';
import '../../constant/images.dart';
import '../../constant/preferences_key.dart';
import '../all_data/model/all_data_model.dart';
import '../gig_detail_screen.dart';
import 'gig_screen.dart';

class GigListScreen extends StatefulWidget {
  const GigListScreen({Key? key}) : super(key: key);

  @override
  _GigListScreenState createState() => _GigListScreenState();
}

class _GigListScreenState extends State<GigListScreen> {
  late AllDataModel prefData;
  late LoginModel loginData;

  //List<Gigs> user = [];
  List<Gigs> gigs = [];
  List username = [];
  String? selectedUserId;

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
          gigs.add(prefData.result!.gigs![i]);
        }
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
    // gigs.sort((a, b) {
    //   return a.user!.compareTo(b.user!);
    // });
    for (int i = 0; i < gigs.length; i++) {
      for (int j = 0; j < prefData.result!.users!.length; j++) {
        if (gigs[i].user == prefData.result!.users![j].id) {
          print(prefData.result!.users![j].firstName);
          username.add(prefData.result!.users![j].firstName);
        }
      }
    }
    //  for (int i = 0; i < gigs.length; i++) {
    //   if (gigs[i].user == prefData.result!.users![gigs[i].user! - 1].id) {
    //     username.add(prefData.result!.users![gigs[i].user! - 1].firstName);
    //   }
    // }
    print(username.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colorses.red,
        height: size.height,
        child: Stack(
          children: [
            ListView.builder(
                padding: EdgeInsets.only(top: size.height * 0.16),
                shrinkWrap: true,
                itemCount: gigs.length,
                itemBuilder: ((context, index) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildListItem(size: size, index: index),
                  ));
                })),
            CommanHeader(
              text: Strings.gigsStr,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem({Size? size, int? index}) {
    return InkWell(
      onTap: () {
        print(gigs[index!].id!);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GigPage(
                    index: index,
                    gigId: gigs[index].id!,
                    userId: gigs[index].user!,
                    userName: username[index],
                    location: gigs[index].location!,
                    gigsdetails: gigs,
                    date: getOnlyDate(dates: gigs[index].startDate!),
                    month: getOnlyMonth(dates: gigs[index].startDate!),
                    profilePic: gigs[index].profilePic!,
                    coverPic: gigs[index].coverImage!,
                  )),
        );
      },
      child: Stack(
        children: [
          Container(
            width: size!.width / 1.05,
            height: 135,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Container(
                color: Colorses.black,
                child: Image.network(
                  gigs[index!].coverImage!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: size.width / 1.05,
            height: 135,
            padding: EdgeInsets.only(top: 5, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.network(gigs[index].profilePic!))),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          username[index],
                          style: TextStyle(
                              color: Colorses.white,
                              fontSize: 20,
                              fontFamily: "Inter-Medium"),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gigs[index].title!,
                          style: TextStyle(
                              color: Colorses.white,
                              fontSize: 20,
                              fontFamily: "Inter-SemiBold"),
                        ),
                        Text(
                          gigs[index].location!,
                          style: TextStyle(
                              color: Colorses.white,
                              fontSize: 16,
                              fontFamily: "Inter-Regular"),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        getOnlyDate(dates: gigs[index].startDate!),
                        style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            color: Colorses.white,
                            fontSize: 30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        getOnlyMonth(dates: gigs[index].startDate!),
                        style: TextStyle(
                            fontFamily: 'Inter-Regular',
                            color: Colorses.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
