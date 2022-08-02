import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class ContactsScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  int userId;
  ContactsScreen(
      {Key? key,
      required this.userName,
      required this.location,
      required this.date,
      required this.coverPic,
      required this.profilePic,
      required this.month,
      required this.userId,
      required this.gigId})
      : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late AllDataModel prefData;
  List<Contacts> contactsList = [];
  List<Contacts> travelligContect = [];
  @override
  void initState() {
    // TODO: implement initState
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));

    for (int i = 0; i < prefData.result!.contacts!.length; i++) {
      if (widget.gigId == prefData.result!.contacts![i].gig &&
          widget.userId == prefData.result!.contacts![i].user) {
        if (prefData.result!.contacts![i].travellingParty!) {
          travelligContect.add(prefData.result!.contacts![i]);
        } else {
          contactsList.add(prefData.result!.contacts![i]);
        }
      }
    }

    print(contactsList);
    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _textMe(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colorses.red,
      appBar: buildAppbar(context: context, text: Strings.contactsStr),
      body: SingleChildScrollView(
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
                Column(
                  children: [
                    contactsList.isNotEmpty
                        ? buildContects(size: size)
                        : SizedBox(),
                    travelligContect.isNotEmpty
                        ? buildTravelligPart(size: size)
                        : SizedBox()
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildContects({required Size size}) {
    return Container(
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
              vertical: size.height * 0.02, horizontal: size.width * 0.05),
          child: Column(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contactsList.length,
                  itemBuilder: ((context, index) {
                    print(contactsList.last);
                    return Column(
                      children: [
                        buildListItem(
                            title: contactsList[index].type!,
                            subTitle: contactsList[index].name!,
                            callTap: () {
                              _makePhoneCall(contactsList[index].number!);
                            },
                            msgTap: () {
                              _textMe(contactsList[index].number!);
                            }),
                        index == contactsList.length - 1
                            ? SizedBox()
                            : buildViewLine(size: size)
                      ],
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTravelligPart({required Size size}) {
    return Container(
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
              vertical: size.height * 0.02, horizontal: size.width * 0.05),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    color: Colorses.black,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: travelligContect.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        buildListItemforTravelling(
                            title: travelligContect[index].type!,
                            subTitle: travelligContect[index].name!,
                            callTap: () {
                              _makePhoneCall(contactsList[index].number!);
                            },
                            msgTap: () {
                              _textMe(contactsList[index].number!);
                            }),
                        index == travelligContect.length - 1
                            ? SizedBox()
                            : buildViewLine(size: size)
                      ],
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem(
      {required String title,
      required String subTitle,
      required void Function() callTap,
      required void Function() msgTap}) {
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
                title,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.black,
                    fontSize: 14),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.red,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        InkWell(onTap: callTap, child: SvgPicture.asset(Images.callImage)),
        InkWell(onTap: msgTap, child: SvgPicture.asset(Images.msgImage))
      ],
    );
  }

  Widget buildListItemforTravelling(
      {required String title,
      required String subTitle,
      required void Function() callTap,
      required void Function() msgTap}) {
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
                title,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.black,
                    fontSize: 14),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.red,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        SvgPicture.asset(Images.emailImage),
        InkWell(onTap: callTap, child: SvgPicture.asset(Images.callImage)),
        InkWell(onTap: msgTap, child: SvgPicture.asset(Images.msgImage))
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
