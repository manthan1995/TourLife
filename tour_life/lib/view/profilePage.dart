import 'package:flutter/material.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/strings.dart';

import '../widget/commanBtn.dart';
import '../widget/commanHeader.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Colorses.grey,
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
            fontFamily: 'Inter-Regular',
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: size!.height * 0.010,
        ),
        Text(
          Strings.logInEmailStr,
          style: TextStyle(fontSize: 18, fontFamily: 'Inter-Medium'),
        ),
        SizedBox(
          height: size.height * 0.010,
        ),
        CommanBtn(
          text: Strings.logOutStr,
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
            fontFamily: 'Inter-Regular',
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: size!.height * 0.010,
        ),
        Text(
          Strings.iCalLinkUrl,
          style: TextStyle(fontSize: 15, fontFamily: 'Inter-Medium'),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.010,
        ),
        CommanBtn(
          text: Strings.copyStr,
        ),
      ],
    );
  }

  Widget buildSyncNowPart({Size? size}) {
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
                    Strings.toDayTimeStr,
                    style: TextStyle(fontSize: 15, fontFamily: 'Inter-Medium'),
                  ),
                  Text(
                    Strings.timeStr,
                    style: TextStyle(
                      fontFamily: 'Inter-Light',
                      color: Colorses.grey,
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
          CommanBtn(
            text: Strings.syncNowStr,
          ),
        ],
      ),
    );
  }

  Widget commanViewLine({Size? size}) {
    return Container(
      width: size!.width / 1.2,
      height: 1,
      color: Colorses.grey,
    );
  }
}
