import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tour_life/constant/colorses.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/gig_screen/schedules/car/car_journey.dart';
import 'package:tour_life/view/gig_screen/schedules/flight/flight_journey_screen.dart';
import 'package:tour_life/view/gig_screen/schedules/set_time/set_time_screen.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:tour_life/widget/commanHeaderBg.dart';
import '../../../constant/date_time.dart';
import '../../../constant/images.dart';
import '../../../constant/preferences_key.dart';
import '../../../model/all_data_model.dart';

class ScheduleScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  int? userId;
  List<Gigs> gigsdetails = [];

  ScheduleScreen(
      {Key? key,
      required this.gigId,
      this.userId,
      required this.userName,
      required this.date,
      required this.month,
      required this.coverPic,
      required this.profilePic,
      required this.gigsdetails,
      required this.location})
      : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late AllDataModel prefData;
  List<Schedule>? allDataList = [];
  List<Schedule>? scheduleList = [];
  List finaldatelist = [];
  DateTime? d;
  DateTime? a;

  @override
  void initState() {
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));
    scheduleList = prefData.result!.schedule;

    for (int i = 0; i < scheduleList!.length; i++) {
      // print(prefData.result!.schedule![i].user);
      if (widget.userId
          .toString()
          .contains(prefData.result!.schedule![i].user.toString())) {
        if (prefData.result!.schedule![i].gig == widget.gigId) {
          allDataList!.add(prefData.result!.schedule![i]);
        }
      }
    }

    List datelist = [];
    for (int i = 0; i < allDataList!.length; i++) {
      datelist.add(getDate(dates: allDataList![i].departTime));
    }
    finaldatelist = datelist.toSet().toList();

    allDataList!.sort((a, b) {
      return DateTime.parse(a.departTime!)
          .compareTo(DateTime.parse(b.departTime!));
    });

    DateFormat inputFormat = DateFormat('E dd MMM');

    finaldatelist.sort((a, b) {
      return inputFormat
          .parse(a.toString())
          .compareTo(inputFormat.parse(b.toString()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.scheduleStr,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colorses.white,
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
                  buildForgroundPart(size: size),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForgroundPart({Size? size}) {
    return Container(
      margin: EdgeInsets.only(
        left: size!.height * 0.02,
        right: size.height * 0.02,
        top: size.height * 0.15,
      ),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colorses.red,
        boxShadow: [
          BoxShadow(
            color: Colorses.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      width: size.width,
      child: Column(
        children: [
          buildTravellerPart(size: size),
          buildDriverCard(size: size),
        ],
      ),
    );
  }

  Widget buildDriverCard({Size? size}) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: size!.height * 0.01, horizontal: size.width * 0.03),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: finaldatelist.length,
              itemBuilder: ((context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colorses.black,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          finaldatelist[index],
                          style: TextStyle(
                              color: Colorses.white,
                              fontFamily: 'Inter-Medium',
                              fontSize: 15),
                        )),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allDataList!.length,
                        itemBuilder: ((context, i) {
                          return finaldatelist[index] ==
                                  getDate(dates: allDataList![i].departTime)
                              ? Column(
                                  children: [
                                    buildListItem(index: i),
                                    i == allDataList!.length - 1
                                        ? const SizedBox()
                                        : buildViewLine(size: size, height: 1)
                                  ],
                                )
                              : const SizedBox();
                        }))
                  ],
                );
              })),
        ));
  }

  Widget buildListItem({int? index}) {
    int hourse = DateTime.parse(allDataList![index!].arrivalTime.toString())
        .difference(DateTime.parse(allDataList![index].departTime.toString()))
        .inHours;
    int minit = DateTime.parse(allDataList![index].arrivalTime.toString())
            .difference(
                DateTime.parse(allDataList![index].departTime.toString()))
            .inMinutes %
        60;
    return InkWell(
      onTap: () {
        if (allDataList![index].type.toString().contains("flight")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FlightJourneyPage(
                      id: index,
                      flightDataList: allDataList,
                      userName: widget.userName,
                      date: widget.date,
                      month: widget.month,
                      location: widget.location,
                      profilePic: widget.profilePic,
                      coverPic: widget.coverPic,
                    )),
          );
        } else if (allDataList![index].type.toString().contains("cab")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CarJourney(
                      id: index,
                      carDataList: allDataList,
                      userName: widget.userName,
                      date: widget.date,
                      month: widget.month,
                      profilePic: widget.profilePic,
                      coverPic: widget.coverPic,
                      location: widget.location,
                    )),
          );
        } else if (allDataList![index].type.toString().contains("settime")) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SetTimeScreen(
                      id: index,
                      setTimeDataList: allDataList,
                      userName: widget.userName,
                      location: widget.location,
                      date: widget.date,
                      month: widget.month,
                      profilePic: widget.profilePic,
                      coverPic: widget.coverPic,
                    )),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          allDataList![index].type.toString().contains("flight")
              ? SvgPicture.asset(
                  Images.planeImage,
                )
              : allDataList![index].type.toString().contains("cab")
                  ? SvgPicture.asset(
                      Images.carImage,
                    )
                  : SvgPicture.asset(
                      Images.settimeIconImage,
                    ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "${getTime(times: allDataList![index].departTime)}",
                    style: TextStyle(
                      color: Colorses.grey,
                      fontSize: 15,
                      fontFamily: 'Inter-SemiBold',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: allDataList![index]
                                  .type
                                  .toString()
                                  .contains("settime")
                              ? " - Set Time"
                              : allDataList![index]
                                      .type
                                      .toString()
                                      .contains("flight")
                                  ? " - Flight"
                                  : " - Car",
                          style: TextStyle(color: Colorses.red)),
                      TextSpan(
                          text: allDataList![index]
                                  .type
                                  .toString()
                                  .contains("cab")
                              ? " from"
                              : allDataList![index]
                                      .type
                                      .toString()
                                      .contains("flight")
                                  ? " from"
                                  : "",
                          style: TextStyle(color: Colorses.grey)),
                      TextSpan(
                          text: allDataList![index]
                                  .type
                                  .toString()
                                  .contains("settime")
                              ? ""
                              : allDataList![index]
                                      .type
                                      .toString()
                                      .contains("flight")
                                  ? " ${allDataList![index].departLocation}"
                                  : " ${allDataList![index].departLocation}",
                          style: TextStyle(color: Colorses.red)),
                      TextSpan(
                          text: allDataList![index]
                                  .type
                                  .toString()
                                  .contains("settime")
                              ? ""
                              : allDataList![index]
                                      .type
                                      .toString()
                                      .contains("flight")
                                  ? " to"
                                  : " to",
                          style: TextStyle(color: Colorses.grey)),
                      TextSpan(
                          text: allDataList![index]
                                  .type
                                  .toString()
                                  .contains("settime")
                              ? ""
                              : allDataList![index]
                                      .type
                                      .toString()
                                      .contains("flight")
                                  ? " ${allDataList![index].arrivalLocation}"
                                  : " ${allDataList![index].arrivalLocation}",
                          style: TextStyle(color: Colorses.red)),
                    ],
                  ),
                ),
                Text(
                  "${widget.userName} at ${widget.location} - ${hourse == 0 ? "" : "$hourse h"} ${minit == 0 ? "" : "$minit m"}",
                  style: TextStyle(
                    color: Colorses.black,
                    fontSize: 12,
                    fontFamily: 'Inter-Medium',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTravellerPart({Size? size}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size!.width * 0.08,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.travellerStr,
                style: TextStyle(
                  color: Colorses.white,
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                Strings.selectUserStr,
                style: TextStyle(
                  color: Colorses.white,
                  fontSize: 16,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_drop_down_rounded,
            color: Colorses.black,
            size: 50,
          )
        ],
      ),
    );
  }

  Widget buildViewLine({Size? size, double? height}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size!.height * 0.01, horizontal: size.height * 0.01),
      width: size.width / 1.2,
      height: height,
      color: Colorses.grey,
    );
  }
}
