import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:tour_life/widget/commanHeaderBg.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(context: context, text: Strings.documentsStr),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                CommanHeaderBg(),
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
                    child: Column(
                      children: [
                        buildListItem(
                            title: Strings.boardingPassStr,
                            subtitle: "2 ${Strings.passesStr}"),
                        buildViewLine(size: size),
                        buildListItem(
                            title: Strings.flightConfirmationStr,
                            subtitle: "2 ${Strings.ticketStr}"),
                        buildViewLine(size: size),
                        buildListItem(
                            title: Strings.hotelVoucherStr,
                            subtitle: "2 ${Strings.voucherStr}"),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListItem({String? title, String? subtitle}) {
    return ListTile(
      leading: SvgPicture.asset(Images.tikcetImage),
      title: Text(
        title!,
        style: TextStyle(
            fontFamily: 'Inter-SemiBold', color: Colorses.red, fontSize: 17),
      ),
      subtitle: Text(
        subtitle!,
        style: TextStyle(
            fontFamily: 'Inter-Medium', color: Colorses.black, fontSize: 12),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colorses.black,
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
