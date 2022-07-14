import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanHeader.dart';

import '../../constant/images.dart';
import '../../constant/preferences_key.dart';
import '../gig_detail_screen.dart';
import 'gig_screen.dart';

class GigListScreen extends StatefulWidget {
  const GigListScreen({Key? key}) : super(key: key);

  @override
  _GigListScreenState createState() => _GigListScreenState();
}

class _GigListScreenState extends State<GigListScreen> {
  late Map<String, dynamic> prefData;
  List gigs = [];

  @override
  void initState() {
    // TODO: implement initState
    var data = preferences.getString(Keys.allReponse);
    prefData = jsonDecode(data!);
    gigs = prefData["result"]["gigs"];
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GigPage(
                    index: index!,
                    id: prefData["result"]["gigs"][index]["id"],
                  )),
        );
      },
      child: Stack(
        children: [
          Container(
            width: size!.width / 1.05,
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Container(
                color: Colorses.black,
                child: Image.asset(Images.gigBgImage),
              ),
            ),
          ),
          Container(
            width: size.width / 1.05,
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: Image.asset(Images.apicImage),
                  title: Text(
                    prefData["result"]["users"][1]["first_name"],
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 20,
                        fontFamily: "Inter-Medium"),
                  ),
                ),
                ListTile(
                  title: Text(
                    prefData["result"]["gigs"][index]["title"],
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 20,
                        fontFamily: "Inter-SemiBold"),
                  ),
                  subtitle: Text(
                    prefData["result"]["gigs"][index]["location"],
                    style: TextStyle(
                        color: Colorses.white,
                        fontSize: 16,
                        fontFamily: "Inter-Regular"),
                  ),
                  trailing: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SvgPicture.asset(
                        Images.calendarImage,
                        width: 80,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          " 24\nJUN",
                          style: TextStyle(
                              fontFamily: 'Inter-Bold',
                              color: Colorses.red,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
