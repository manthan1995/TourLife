import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import '../../../constant/colorses.dart';
import '../../../constant/images.dart';
import '../../../constant/preferences_key.dart';
import '../../../widget/commanHeaderBg.dart';
import '../../../model/all_data_model.dart';
import 'package:flutter_share/flutter_share.dart';

class GuestListScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  int userId;
  GuestListScreen(
      {Key? key,
      required this.userName,
      required this.date,
      required this.month,
      required this.location,
      required this.gigId,
      required this.coverPic,
      required this.profilePic,
      required this.userId})
      : super(key: key);

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  late AllDataModel prefData;
  late Guestlists guestData;
  @override
  void initState() {
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));
    for (int i = 0; i < prefData.result!.guestlists!.length; i++) {
      if (widget.gigId == prefData.result!.guestlists![i].gigId &&
          widget.userId == prefData.result!.guestlists![i].userId) {
        guestData = (prefData.result!.guestlists![i]);
      }
    }
    super.initState();
  }

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
                  date: widget.date,
                  profilePic: widget.profilePic,
                  coverPic: widget.coverPic,
                  month: widget.month,
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
              vertical: size.height * 0.02, horizontal: size.width * 0.06),
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
                  guestData.guestlist!
                      ? SvgPicture.asset(Images.doneImage)
                      : SvgPicture.asset(Images.unconfirmedImage),
                  Text(
                    guestData.guestlist!
                        ? Strings.confirmedStr
                        : Strings.unConfirmedStr,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.grey,
                        fontSize: 12),
                  )
                ],
              ),
              buildViewLine(size: size),
              Text(
                guestData.guestlistDetail!,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              buildViewLine(size: size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colorses.red,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      margin: const EdgeInsets.only(top: 15),
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
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: guestData.guestlistDetail))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Detail copied to clipboard")));
                          });
                        },
                      )),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colorses.red,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      margin: const EdgeInsets.only(top: 15),
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.share,
                          color: Colorses.white,
                        ),
                        label: Text(
                          "SHARE",
                          style: TextStyle(
                              color: Colorses.white,
                              fontFamily: 'Inter-Medium',
                              fontSize: 12),
                        ),
                        onPressed: () async {
                          await FlutterShare.share(
                              title: 'Guest List',
                              text: guestData.guestlistDetail!,
                              linkUrl: 'https://flutter.dev/',
                              chooserTitle: 'Example Chooser Title');
                        },
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
