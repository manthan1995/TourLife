import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanHeader.dart';

import '../../constant/images.dart';

class GigListScreen extends StatefulWidget {
  const GigListScreen({Key? key}) : super(key: key);

  @override
  _GigListScreenState createState() => _GigListScreenState();
}

class _GigListScreenState extends State<GigListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colorses.red,
        child: Stack(
          children: [
            ListView.builder(
                padding: EdgeInsets.only(top: size.height * 0.16),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildListItem(size: size),
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

  Widget buildListItem({Size? size}) {
    return Stack(
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
                  "Xzibit",
                  style: TextStyle(
                      color: Colorses.white,
                      fontSize: 20,
                      fontFamily: "Inter-Medium"),
                ),
              ),
              ListTile(
                title: Text(
                  "HIDEOUT FESTIVAL",
                  style: TextStyle(
                      color: Colorses.white,
                      fontSize: 20,
                      fontFamily: "Inter-SemiBold"),
                ),
                subtitle: Text(
                  "Novalia, Croatia",
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
    );
  }
}
