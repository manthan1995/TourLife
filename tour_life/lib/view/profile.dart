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
    return Column(
      children: [
        buildHeader(),
        SizedBox(
          height: 40,
        ),
        buildLogOutPart(),
        SizedBox(
          height: 30,
        ),
        commanViewLine(),
        SizedBox(
          height: 30,
        ),
        buildCopyPart(),
        SizedBox(
          height: 30,
        ),
        commanViewLine(),
        SizedBox(
          height: 30,
        ),
        buildSyncNowPart()
      ],
    );
  }

  Widget buildHeader() {
    return const CommanHeader(
      text: Strings.profileStr,
    );
  }

  Widget buildLogOutPart() {
    return Column(
      children: const [
        Text(
          Strings.loggedInAsStr,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Strings.logInEmailStr,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        CommanBtn(
          text: Strings.logOutStr,
        ),
      ],
    );
  }

  Widget buildCopyPart() {
    return Column(
      children: const [
        Text(
          Strings.iCalLinkStr,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Strings.iCalLinkUrl,
          style: TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        CommanBtn(
          text: Strings.copyStr,
        ),
      ],
    );
  }

  Widget buildSyncNowPart() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  Strings.lastSyncedStr,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  Strings.iCalLinkStr,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget commanViewLine() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.2,
      height: 1,
      color: Colorses.grey,
    );
  }
}
