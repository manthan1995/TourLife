import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/images.dart';

import '../constant/colorses.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({Key? key}) : super(key: key);

  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.journeyStr,
      ),
      body: Container(
        color: Colorses.white,
        child: Column(
          children: [
            Stack(
              children: [
                buildHeaderbg(),
                Container(
                  margin: EdgeInsets.only(
                    left: size.height * 0.02,
                    right: size.height * 0.02,
                    top: size.height * 0.15,
                  ),
                  padding: EdgeInsets.all(15),
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
                  height: size.height * 0.70,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "LAX",
                                style: TextStyle(
                                  color: Colorses.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter-Medium',
                                ),
                              ),
                              Text(
                                "Los Angeles",
                                style: TextStyle(
                                  color: Colorses.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter-Regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.horizontalplaneImage),
                              Text(
                                "9h 42 Min",
                                style: TextStyle(
                                  color: Colorses.white,
                                  fontSize: 14,
                                  fontFamily: 'Inter-Medium',
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    color: Colorses.green,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  child: Text(
                                    "ON SCHEDULE",
                                    style: TextStyle(
                                        color: Colorses.white,
                                        fontFamily: 'Inter-Medium',
                                        fontSize: 12),
                                  ))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "    LHR",
                                style: TextStyle(
                                  color: Colorses.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter-Medium',
                                ),
                              ),
                              Text(
                                "     London",
                                style: TextStyle(
                                  color: Colorses.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter-Regular',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        width: size.width / 1.2,
                        height: 2,
                        color: Colorses.black,
                      ),
                      Text(
                        "Tuesday. May 30, 2022",
                        style: TextStyle(
                          color: Colorses.white,
                          fontSize: 12,
                          fontFamily: 'Inter-Medium',
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.03),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "British Airways",
                                        style: TextStyle(
                                          color: Colorses.black,
                                          fontSize: 15,
                                          fontFamily: 'Inter-Medium',
                                        ),
                                      ),
                                      Text(
                                        "BA 282",
                                        style: TextStyle(
                                          color: Colorses.red,
                                          fontSize: 12,
                                          fontFamily: 'Inter-Medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(Images.britishairwaysImage)
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01,
                                ),
                                width: size.width / 1.2,
                                height: 1,
                                color: Colorses.black,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width: 15,
                                      height: 15,
                                      child: SvgPicture.asset(
                                          Images.roundedBackImage)),
                                  Text(
                                    "Non-Stop",
                                    style: TextStyle(
                                      color: Colorses.red,
                                      fontSize: 12,
                                      fontFamily: 'Inter-Medium',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(Images.planebarImage)
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width * 0.65,
                                    child: Column(
                                      children: [
                                        buildFligthTimeTile(
                                            departArrive: "Depart"),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        buildFligthTimeTile(
                                            departArrive: "Arrive"),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Flight Number',
                                                    style: TextStyle(
                                                      color: Colorses.red,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'Inter-Regular',
                                                    ),
                                                  ),
                                                  Text(
                                                    "BA 282",
                                                    style: TextStyle(
                                                      color: Colorses.black,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Inter-Medium',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              buildGradientLine(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Classs     ',
                                                    style: TextStyle(
                                                      color: Colorses.red,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'Inter-Regular',
                                                    ),
                                                  ),
                                                  Text(
                                                    "Business     ",
                                                    style: TextStyle(
                                                      color: Colorses.black,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Inter-Medium',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Destination forecast",
                                style: TextStyle(
                                  color: Colorses.red,
                                  fontSize: 14,
                                  fontFamily: 'Inter-SemiBold',
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "27°C  ",
                                        style: TextStyle(
                                          color: Colorses.black,
                                          fontSize: 16,
                                          fontFamily: 'Inter-SemiBold',
                                        ),
                                      ),
                                      Text(
                                        "Light Rain  ",
                                        style: TextStyle(
                                          color: Colorses.grey,
                                          fontSize: 12,
                                          fontFamily: 'Inter-Medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(Images.cloudweatherImage)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Traveller",
                                  style: TextStyle(
                                    color: Colorses.white,
                                    fontSize: 14,
                                    fontFamily: 'Inter-Medium',
                                  ),
                                ),
                                Text(
                                  "Select a user",
                                  style: TextStyle(
                                    color: Colorses.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter-Medium',
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colorses.black,
                                size: 50,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderbg() {
    return CoomanHeaderBg();
  }

  Widget buildGradientLine() {
    return Image.asset(Images.gradientLineImage);
  }

  Widget buildFligthTimeTile({String? departArrive}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                departArrive!,
                style: TextStyle(
                  color: Colorses.red,
                  fontSize: 14,
                  fontFamily: 'Inter-Regular',
                ),
              ),
              Text(
                "Thu, 23 Jun",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 10,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                "4:08 PM",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                "Los Angeles International",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 10,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ],
          ),
          buildGradientLine(),
          Column(
            children: [
              Text(
                "Terminal",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 12,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                "B",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ],
          ),
          buildGradientLine(),
          Column(
            children: [
              Text(
                "Gate",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 12,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                "-",
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
