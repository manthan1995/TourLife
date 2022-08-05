import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/gig_screen/documents/passes/passes_screen.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:tour_life/widget/commanHeaderBg.dart';

import '../../../constant/colorses.dart';
import '../../../constant/images.dart';

class DocumentScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  int userId;
  DocumentScreen(
      {Key? key,
      required this.userName,
      required this.location,
      required this.date,
      required this.month,
      required this.coverPic,
      required this.profilePic,
      required this.gigId,
      required this.userId})
      : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
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
                CommanHeaderBg(
                  title: widget.userName,
                  subTitle: widget.location,
                  date: widget.date,
                  month: widget.month,
                  profilePic: widget.profilePic,
                  coverPic: widget.coverPic,
                ),
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
                          subtitle: "2 ${Strings.passesStr}",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PassesScreen(
                                        userName: widget.userName,
                                        location: widget.location,
                                        gigId: widget.gigId,
                                        userId: widget.userId,
                                        profilePic: widget.profilePic,
                                        coverPic: widget.coverPic,
                                        date: widget.date,
                                        month: widget.month,
                                        type: "BOARDING_PASSES",
                                      )),
                            );
                          },
                        ),
                        buildViewLine(size: size),
                        buildListItem(
                          title: Strings.flightConfirmationStr,
                          subtitle: "2 ${Strings.ticketStr}",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PassesScreen(
                                        userName: widget.userName,
                                        location: widget.location,
                                        gigId: widget.gigId,
                                        profilePic: widget.profilePic,
                                        coverPic: widget.coverPic,
                                        userId: widget.userId,
                                        date: widget.date,
                                        month: widget.month,
                                        type: "FLIGHT_CONFIRMATIONS",
                                      )),
                            );
                          },
                        ),
                        buildViewLine(size: size),
                        buildListItem(
                          title: Strings.hotelVoucherStr,
                          subtitle: "2 ${Strings.voucherStr}",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PassesScreen(
                                        userName: widget.userName,
                                        location: widget.location,
                                        gigId: widget.gigId,
                                        userId: widget.userId,
                                        date: widget.date,
                                        month: widget.month,
                                        profilePic: widget.profilePic,
                                        coverPic: widget.coverPic,
                                        type: "HOTEL_VOUCHER",
                                      )),
                            );
                          },
                        ),
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

  Widget buildListItem(
      {String? title, String? subtitle, void Function()? onTap}) {
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
      onTap: onTap,
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
