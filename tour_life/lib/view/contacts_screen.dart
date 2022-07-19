import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';
import '../widget/commanHeaderBg.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(context: context, text: Strings.contactsStr),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                CommanHeaderBg(
                  title: "srh",
                  subTitle: "syh",
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: size.height * 0.01,
                        right: size.height * 0.01,
                        top: size.height * 0.15,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.05),
                          child: Column(
                            children: [
                              buildListItem(),
                              buildViewLine(size: size),
                              buildListItem(),
                              buildViewLine(size: size),
                              buildListItem(),
                              buildViewLine(size: size),
                              buildListItem(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: size.height * 0.01,
                        right: size.height * 0.01,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.05),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    color: Colorses.black,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    "TRAVELLING PARTY",
                                    style: TextStyle(
                                        color: Colorses.white,
                                        fontFamily: 'Inter-Medium',
                                        fontSize: 15),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              buildListItem(),
                              buildViewLine(size: size),
                              buildListItem(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Emergency",
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.black,
                    fontSize: 14),
              ),
              Text(
                "Attilo",
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.red,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        SvgPicture.asset(Images.callImage),
        SvgPicture.asset(Images.msgImage)
      ],
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
