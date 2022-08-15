import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/lists.dart';
import 'package:tour_life/view/gig_screen/contects/contacts_screen.dart';
import 'package:tour_life/view/gig_screen/documents/documents.dart';
import 'package:tour_life/view/gig_screen/guest_list/guest_list.dart';
import 'package:tour_life/view/gig_screen/hotels/hotel.dart';
import 'package:tour_life/view/gig_screen/running_order/running_order.dart';
import 'package:tour_life/view/gig_screen/venues/venue.dart';
import '../../constant/colorses.dart';
import '../../constant/preferences_key.dart';
import '../../constant/strings.dart';
import '../../model/auth_model/login_model.dart';
import '../../widget/commanAppBar.dart';
import '../../widget/commanHeaderBg.dart';
import '../../model/all_data_model.dart';
import 'gig_detail/gig_detail_screen.dart';
import 'schedules/schedule_screen.dart';

class GigPage extends StatefulWidget {
  int index;
  int gigId;
  int userId;
  String userName;
  String location;
  List<Gigs> gigsdetails = [];
  String date;
  String month;
  String profilePic;
  String coverPic;

  GigPage(
      {Key? key,
      required this.index,
      required this.gigId,
      required this.userId,
      required this.userName,
      required this.location,
      required this.coverPic,
      required this.profilePic,
      required this.gigsdetails,
      required this.date,
      required this.month})
      : super(key: key);

  @override
  State<GigPage> createState() => _GigPageState();
}

class _GigPageState extends State<GigPage> {
  late AllDataModel prefData;
  late LoginModel loginData;
  String? selectedUserId;
  List<Gigs> gigs = [];
  @override
  void initState() {
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));

    var logindata = preferences.getString(Keys.loginReponse);
    loginData = LoginModel.fromJson(jsonDecode(logindata!));

    selectedUserId = preferences.getString(Keys.dropDownValue);

    if (loginData.result!.isManager!) {
      if (preferences.getBool(Keys.ismanagerValue) == null ||
          preferences.getBool(Keys.ismanagerValue)!) {
        for (int i = 0; i < prefData.result!.gigs!.length; i++) {
          if (widget.gigId == prefData.result!.gigs![i].id) {
            gigs.add(prefData.result!.gigs![i]);
          }
        }
      } else {
        for (int i = 0; i < prefData.result!.gigs!.length; i++) {
          if (selectedUserId!
                  .contains(prefData.result!.gigs![i].user.toString()) &&
              widget.gigId == prefData.result!.gigs![i].id) {
            gigs.add(prefData.result!.gigs![i]);
          }
        }
      }
    } else {
      for (int i = 0; i < prefData.result!.gigs!.length; i++) {
        if (loginData.result!.id
                .toString()
                .contains(prefData.result!.gigs![i].user.toString()) &&
            widget.gigId == prefData.result!.gigs![i].id) {
          gigs.add(prefData.result!.gigs![i]);
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.gigStr,
      ),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                buildHeaderbg(),
                buildCard(size: size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderbg() {
    return CommanHeaderBg(
      title: widget.userName,
      subTitle: widget.location,
      date: widget.date,
      month: widget.month,
      profilePic: widget.profilePic,
      coverPic: widget.coverPic,
    );
  }

  Widget buildCard({Size? size}) {
    return Container(
      margin: EdgeInsets.only(
        left: size!.height * 0.02,
        right: size.height * 0.02,
        top: size.height * 0.18,
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colorses.white,
        boxShadow: [
          BoxShadow(
            color: Colorses.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            // shadow direction: bottom right
          )
        ],
      ),
      width: size.width,
      child: Column(
        children: [
          buildListTile(
              leadingImage: Lists.giglistImage[0],
              text: Lists.giglist[0],
              trailing: Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GigDetailPage(
                            gigsdetails: widget.gigsdetails,
                            index: widget.index,
                            userName: widget.userName,
                            date: widget.date,
                            month: widget.month,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[1],
              text: Lists.giglist[1],
              trailing: Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Venue(
                            gigId: widget.gigId,
                            userName: widget.userName,
                            location: widget.location,
                            userId: widget.userId,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            date: widget.date,
                            month: widget.month,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[2],
              text: Lists.giglist[2],
              trailing: Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelScreen(
                            gigId: widget.gigId,
                            userName: widget.userName,
                            location: widget.location,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            userId: widget.userId,
                            date: widget.date,
                            month: widget.month,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[3],
              text: Lists.giglist[3],
              trailing: widget.gigsdetails[widget.index].scheduleCount == 0
                  ? Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Colorses.red,
                      ),
                      child: Text(
                        widget.gigsdetails[widget.index].scheduleCount
                            .toString(),
                        style: TextStyle(color: Colorses.white),
                      ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleScreen(
                            gigId: widget.gigId,
                            userId: widget.userId,
                            userName: widget.userName,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            location: widget.location,
                            gigsdetails: widget.gigsdetails,
                            date: widget.date,
                            month: widget.month,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[4],
              text: Lists.giglist[4],
              trailing: widget.gigsdetails[widget.index].contactCount == 0
                  ? Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Colorses.red,
                      ),
                      child: Text(
                        widget.gigsdetails[widget.index].contactCount
                            .toString(),
                        style: TextStyle(color: Colorses.white),
                      ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactsScreen(
                            userName: widget.userName,
                            location: widget.location,
                            gigId: widget.gigId,
                            userId: widget.userId,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            date: widget.date,
                            month: widget.month,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[5],
              text: Lists.giglist[5],
              trailing: widget.gigsdetails[widget.index].documentCount == 0
                  ? Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Colorses.red,
                      ),
                      child: Text(
                        widget.gigsdetails[widget.index].documentCount
                            .toString(),
                        style: TextStyle(color: Colorses.white),
                      ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DocumentScreen(
                            userName: widget.userName,
                            location: widget.location,
                            gigId: widget.gigId,
                            userId: widget.userId,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            date: widget.date,
                            month: widget.month,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[6],
              text: Lists.giglist[6],
              trailing: gigs.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Colorses.red,
                      ),
                      child: Text(
                        gigs.length.toString(),
                        style: TextStyle(color: Colorses.white),
                      ),
                    ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RunningOrder(
                            userName: widget.userName,
                            location: widget.location,
                            date: widget.date,
                            month: widget.month,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            gigId: widget.gigId,
                          )),
                );
              }),
          buildViewLine(),
          buildListTile(
              leadingImage: Lists.giglistImage[7],
              text: Lists.giglist[7],
              trailing: Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GuestListScreen(
                            userName: widget.userName,
                            location: widget.location,
                            gigId: widget.gigId,
                            date: widget.date,
                            profilePic: widget.profilePic,
                            coverPic: widget.coverPic,
                            month: widget.month,
                            userId: widget.userId,
                          )),
                );
              }),
        ],
      ),
    );
  }

  Widget buildListTile(
      {String? text,
      Widget? trailing,
      String? leadingImage,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListTile(
          leading: SvgPicture.asset(leadingImage!),
          title: Center(
            child: Text(
              text!,
              style: TextStyle(
                color: Colorses.black,
                fontSize: 18,
                fontFamily: 'Inter-Medium',
              ),
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }

  Widget buildViewLine() {
    return Container(
      height: 1,
      color: Colorses.grey,
      margin: const EdgeInsets.symmetric(horizontal: 25),
    );
  }
}
