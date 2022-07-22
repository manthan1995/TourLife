import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:tour_life/widget/commanHeader.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';
import '../widget/commanHeaderBg.dart';

class GuestListScreen extends StatefulWidget {
  String userName;
  String location;
  GuestListScreen({Key? key, required this.userName, required this.location})
      : super(key: key);

  @override
  _GuestListScreenState createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppbar(context: context, text: Strings.guestListStr),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                CommanHeaderBg(
                  title: widget.userName,
                  subTitle: widget.location,
                ),
                buildDetailCard(size: size)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard({Size? size}) {
    return Container(
      margin: EdgeInsets.only(
        left: size!.height * 0.01,
        right: size.height * 0.01,
        top: size.height * 0.15,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          Strings.guestListStr,
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(Images.unconfirmedImage),
                  Text(
                    Strings.unConfirmedStr,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.grey,
                        fontSize: 12),
                  )
                ],
              ),
              buildViewLine(size: size),
              Text(
                "Allocation: 3 x GA\nDeadline: Thursday 23rd June\nHow to submit. by email to\nemily@soundchanneluk.com - please include\nboth NAMES and EMAILS of all quests.\nWhere to collect tickets: accreditation point\nGuestlist manager PRE SHOW:\nemily@soundchanneluk.com\nGuestlist manager SHOW DAY:\nemily@soundchanneluk.com +44 7757 681125",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              buildViewLine(size: size),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Colorses.red,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 5),
                      margin: EdgeInsets.only(top: 15),
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.copy,
                          color: Colorses.white,
                        ),
                        label: Text(
                          Strings.copyToClipBoardStr,
                          style: TextStyle(
                              color: Colorses.white,
                              fontFamily: 'Inter-Medium',
                              fontSize: 12),
                        ),
                        onPressed: () {},
                      )),
                ],
              )
            ],
          ),
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
