import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class PassesScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  int userId;
  String type;
  PassesScreen(
      {Key? key,
      required this.userName,
      required this.date,
      required this.month,
      required this.location,
      required this.coverPic,
      required this.profilePic,
      required this.gigId,
      required this.type,
      required this.userId})
      : super(key: key);

  @override
  _PassesScreenState createState() => _PassesScreenState();
}

class _PassesScreenState extends State<PassesScreen> {
  late AllDataModel prefData;
  List<Documents> doucumentList = [];
  @override
  void initState() {
    // TODO: implement initState
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));
    for (int i = 0; i < prefData.result!.documents!.length; i++) {
      if (widget.gigId == prefData.result!.documents![i].gig &&
          widget.userId == prefData.result!.documents![i].user) {
        if (widget.type == prefData.result!.documents![i].type) {
          doucumentList.add(prefData.result!.documents![i]);
        }
      }
    }
    print(doucumentList);
    super.initState();
  }

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
                  profilePic: widget.profilePic,
                  coverPic: widget.coverPic,
                  month: widget.month,
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
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: doucumentList.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  buildListItem(
                                      title: Strings.boardingPassStr,
                                      subtitle: "2 ${Strings.passesStr}"),
                                  index == doucumentList.length - 1
                                      ? SizedBox()
                                      : buildViewLine(size: size)
                                ],
                              );
                            })),
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
      leading: SvgPicture.asset(Images.pdfImage),
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
