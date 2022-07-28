import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class ContactsScreen extends StatefulWidget {
  String userName;
  String location;
  int id;
  ContactsScreen(
      {Key? key,
      required this.userName,
      required this.location,
      required this.id})
      : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  // late AllDataModel prefData;
  // late Contacts contacts;
  @override
  void initState() {
    // TODO: implement initState
    // var data = preferences.getString(Keys.allReponse);
    // prefData = AllDataModel.fromJson(jsonDecode(data!));

    // for (int i = 0; i < prefData.result!.contacts!.length; i++) {
    //   if (prefData.result!.contacts![i].gig!.contains(widget.id.toString())) {
    //     contacts = (prefData.result!.contacts![i]);
    //   }
    // }
    // print(contacts);
    super.initState();
  }

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
                  title: widget.userName,
                  subTitle: widget.location,
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
                              buildListItem(
                                  title: "Emergency", subTitle: "David"),
                              buildViewLine(size: size),
                              buildListItem(
                                  title: "Emergency", subTitle: "Heather"),
                              buildViewLine(size: size),
                              buildListItem(
                                  title: "Transport coordinator",
                                  subTitle: "Susan"),
                              buildViewLine(size: size),
                              buildListItem(
                                  title: "Artist liaison", subTitle: "Will"),
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
                              buildListItemforTravelling(
                                  title: "Manager", subTitle: "Taydoe"),
                              buildViewLine(size: size),
                              buildListItemforTravelling(
                                  title: "TM", subTitle: "Harry"),
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

  Widget buildListItem({required String title, required String subTitle}) {
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
        SvgPicture.asset(Images.callImage),
        SvgPicture.asset(Images.msgImage)
      ],
    );
  }

  Widget buildListItemforTravelling(
      {required String title, required String subTitle}) {
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
