import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';

class GigDetailPage extends StatefulWidget {
  int index;
  GigDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  _GigDetailPageState createState() => _GigDetailPageState();
}

class _GigDetailPageState extends State<GigDetailPage> {
  late Map<String, dynamic> prefData;
  @override
  void initState() {
    // TODO: implement initState
    var data = preferences.getString(Keys.allReponse);
    prefData = jsonDecode(data!);
    //print(prefData["result"]["gigs"][widget.id]["show"]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.gigDetailsStr,
      ),
      body: Container(
          color: Colorses.black,
          child: Column(children: [
            Stack(
              children: [
                buildBackGround(size: size),
                buildForGroundPart(size: size),
              ],
            ),
          ])),
    );
  }

  Widget buildBackGround({Size? size}) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          color: Colorses.black,
          width: size!.width,
          height: size.height * 0.22,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Image.asset(
              Images.gigBgImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.apicImage,
              width: 80,
              height: 80,
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Xzibit",
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.white,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildForGroundPart({Size? size}) {
    return Container(
      margin: EdgeInsets.only(
        left: size!.height * 0.02,
        right: size.height * 0.02,
        top: size.height * 0.18,
      ),
      child: Column(
        children: [
          buildCalendarCard(size: size),
          buildTimerCard(size: size),
          buildDetailCard(size: size),
        ],
      ),
    );
  }

  Widget buildCalendarCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02, horizontal: size.width * 0.05),
        child: Column(
          children: [
            ListTile(
              leading: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SvgPicture.asset(
                    Images.calendarImage,
                    color: Colorses.red,
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
                          color: Colorses.white,
                          fontSize: 11),
                    ),
                  )
                ],
              ),
              title: Text(
                "The O2 Arena, London",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 18,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ),
            buildViewLine(size: size),
            commanRow(
                size: size,
                leadTitle: Strings.showTypeStr,
                trailTitle: prefData["result"]["gigs"][widget.index]["show"]),
            buildViewLine(size: size),
            commanRow(
                size: size,
                leadTitle: Strings.stageStr,
                trailTitle: prefData["result"]["gigs"][widget.index]["stage"]),
            buildViewLine(size: size),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        Strings.cashCommentStr,
                        style: TextStyle(
                          color: Colorses.grey,
                          fontSize: 12,
                          fontFamily: 'Inter-SemiBold',
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SvgPicture.asset(Images.cashImage)
                    ],
                  ),
                  Text(
                    Strings.noCashStr,
                    style: TextStyle(
                      color: Colorses.black,
                      fontSize: 14,
                      fontFamily: 'Inter-Medium',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget commanRow({Size? size, String? leadTitle, String? trailTitle}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size!.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadTitle!,
            style: TextStyle(
              color: Colorses.red,
              fontSize: 14,
              fontFamily: 'Inter-SemiBold',
            ),
          ),
          Text(
            trailTitle!,
            style: TextStyle(
              color: Colorses.black,
              fontSize: 14,
              fontFamily: 'Inter-Medium',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimerCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.01, horizontal: size.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(Images.timerImage),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fri, 24 June, 2022",
                  style: TextStyle(
                      fontFamily: 'Inter-SemiBold',
                      color: Colorses.black,
                      fontSize: 17),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: Strings.entryStr,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.red),
                    children: <TextSpan>[
                      TextSpan(
                          text: "06:00 PM to 11:00PM",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter-Medium',
                              color: Colorses.grey)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02, horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                Strings.visaStr,
                style: TextStyle(
                    fontFamily: 'Inter-SemiBold',
                    color: Colorses.red,
                    fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                Strings.proofStr,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.black,
                    fontSize: 12),
              ),
            ),
            buildViewLine(size: size),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.equipmentStr,
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                        Text(
                          Strings.riderConfirmedStr,
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              color: Colorses.black,
                              fontSize: 12),
                        ),
                        Text(
                          Strings.emailStr,
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(Images.doneImage),
                  Text(
                    Strings.confirmedStr,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.grey,
                        fontSize: 12),
                  )
                ],
              ),
            ),
            buildViewLine(size: size),
            commanRow(
                size: size,
                leadTitle: Strings.soundCheckStr,
                trailTitle: "02:00 PM"),
          ],
        ),
      ),
    );
  }

  Widget buildViewLine({Size? size}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size!.height * 0.01,
      ),
      width: size.width / 1.2,
      height: 1,
      color: Colorses.grey,
    );
  }
}
