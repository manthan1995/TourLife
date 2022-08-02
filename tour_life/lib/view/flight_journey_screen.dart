import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tour_life/constant/date_time.dart';
import 'package:tour_life/constant/images.dart';
import 'dart:ui' as ui;

import '../constant/colorses.dart';
import '../constant/preferences_key.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class FlightJourneyPage extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int id;
  List<Schedule>? flightDataList = [];

  FlightJourneyPage(
      {Key? key,
      required this.id,
      this.flightDataList,
      required this.date,
      required this.month,
      required this.coverPic,
      required this.profilePic,
      required this.userName,
      required this.location})
      : super(key: key);

  @override
  _FlightJourneyPageState createState() => _FlightJourneyPageState();
}

class _FlightJourneyPageState extends State<FlightJourneyPage> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? mapMarker;
  LatLng? startLocation;
  LatLng? endLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    print(widget.flightDataList![widget.id].departLocation);
    print(widget.flightDataList![widget.id].arrivalLocation);

    startLocation = LatLng(
        double.parse(widget.flightDataList![widget.id].departLatLong
            .toString()
            .split(',')
            .first),
        double.parse(widget.flightDataList![widget.id].departLatLong
            .toString()
            .split(',')
            .last));
    endLocation = LatLng(
        double.parse(widget.flightDataList![widget.id].arrivalLatLong
            .toString()
            .split(',')
            .first),
        double.parse(widget.flightDataList![widget.id].arrivalLatLong
            .toString()
            .split(',')
            .last));

    addMarkers();
    super.initState();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), Images.venueMarkerImage);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  addMarkers() async {
    final Uint8List markerIconStart =
        await getBytesFromAsset(Images.departMarkerImage, 150);

    final Uint8List markerIconEnd =
        await getBytesFromAsset(Images.arriveMarkerImage, 150);

    setState(() {
      markers.add(Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation!, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Starting Point ',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.fromBytes(markerIconStart), //Icon for Marker
      ));
      markers.add(Marker(
        //add end location marker
        markerId: MarkerId(endLocation.toString()),
        position: endLocation!, //position of marker

        infoWindow: InfoWindow(
          //popup info
          title: 'End Point ',
          snippet: 'End Marker',
        ),
        icon: BitmapDescriptor.fromBytes(markerIconEnd), //Icon for Marker
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.flightJourneyStr,
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
                    month: widget.month,
                    profilePic: widget.profilePic,
                    coverPic: widget.coverPic,
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
      child: Column(
        children: [
          buildSchedulePart(),
          buildViewLine(size: size, height: 2),
          Text(
            DateFormat("EEEE dd MMM y").format(
                DateTime.parse(widget.flightDataList![widget.id].departTime!)),
            style: TextStyle(
              color: Colorses.white,
              fontSize: 12,
              fontFamily: 'Inter-Medium',
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          buildAirwayTimeCard(size: size),
          buildDestinationCard(size: size),
          SizedBox(
            height: size.height * 0.01,
          ),
          buildTravellerPart(size: size)
        ],
      ),
    );
  }

  Widget buildSchedulePart() {
    int hourse =
        DateTime.parse(widget.flightDataList![widget.id].arrivalTime.toString())
            .difference(DateTime.parse(
                widget.flightDataList![widget.id].departTime.toString()))
            .inHours;
    int minit =
        DateTime.parse(widget.flightDataList![widget.id].arrivalTime.toString())
                .difference(DateTime.parse(
                    widget.flightDataList![widget.id].departTime.toString()))
                .inMinutes %
            60;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commanText(
            title: "LAX",
            subTitle: widget.flightDataList![widget.id].departLocation),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.horizontalplaneImage),
            Text(
              "${hourse == 0 ? "" : "$hourse h"} ${minit == 0 ? "" : "$minit Min"}",
              style: TextStyle(
                color: Colorses.white,
                fontSize: 14,
                fontFamily: 'Inter-Medium',
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Colorses.green,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(
                  Strings.onSCHEDULEStr,
                  style: TextStyle(
                      color: Colorses.white,
                      fontFamily: 'Inter-Medium',
                      fontSize: 12),
                ))
          ],
        ),
        commanText(
            title: "    LHR",
            subTitle: widget.flightDataList![widget.id].arrivalLocation),
      ],
    );
  }

  Widget buildAirwayTimeCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: GoogleMap(
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: markers,
                  onMapCreated: _onMapCreated,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: startLocation!,
                  ),
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: size!.height * 0.02, horizontal: size.width * 0.03),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.flightDataList![widget.id].airlines!,
                          style: TextStyle(
                            color: Colorses.black,
                            fontSize: 15,
                            fontFamily: 'Inter-Medium',
                          ),
                        ),
                        Text(
                          widget.flightDataList![widget.id].flightNumber!,
                          style: TextStyle(
                            color: Colorses.red,
                            fontSize: 12,
                            fontFamily: 'Inter-Medium',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [Image.asset(Images.britishairwaysImage)],
                    )
                  ],
                ),
                buildViewLine(size: size, height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        width: 15,
                        height: 15,
                        child: SvgPicture.asset(Images.roundedBackImage)),
                    Text(
                      Strings.nonStopStr,
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
                      children: [Image.asset(Images.planebarImage)],
                    ),
                    SizedBox(
                      width: size.width * 0.65,
                      child: Column(
                        children: [
                          buildFligthTimeTile(
                              departArrive: Strings.departStr,
                              date: getDate(
                                  dates: widget
                                      .flightDataList![widget.id].departTime),
                              time: getTime(
                                  times: widget
                                      .flightDataList![widget.id].departTime),
                              address: widget
                                  .flightDataList![widget.id].departLocation,
                              terminal: widget
                                  .flightDataList![widget.id].departTerminal,
                              gate:
                                  widget.flightDataList![widget.id].departGate),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          buildFligthTimeTile(
                              departArrive: Strings.arriveStr,
                              date: getDate(
                                  dates: widget
                                      .flightDataList![widget.id].arrivalTime),
                              time: getTime(
                                  times: widget
                                      .flightDataList![widget.id].arrivalTime),
                              address: widget
                                  .flightDataList![widget.id].arrivalLocation,
                              terminal: widget
                                  .flightDataList![widget.id].arrivalTerminal,
                              gate: widget
                                  .flightDataList![widget.id].arrivalGate),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      Strings.flightNoStr,
                                      style: TextStyle(
                                        color: Colorses.red,
                                        fontSize: 14,
                                        fontFamily: 'Inter-Regular',
                                      ),
                                    ),
                                    Text(
                                      widget.flightDataList![widget.id]
                                          .flightNumber!,
                                      style: TextStyle(
                                        color: Colorses.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter-Medium',
                                      ),
                                    ),
                                  ],
                                ),
                                buildGradientLine(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      Strings.classStr,
                                      style: TextStyle(
                                        color: Colorses.red,
                                        fontSize: 14,
                                        fontFamily: 'Inter-Regular',
                                      ),
                                    ),
                                    Text(
                                      widget.flightDataList![widget.id]
                                          .flightClass!,
                                      style: TextStyle(
                                        color: Colorses.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter-Medium',
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
        ],
      ),
    );
  }

  Widget buildDestinationCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02, horizontal: size.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.destinationStr,
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
                      widget.flightDataList![widget.id].wather!,
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

  Widget buildGradientLine() {
    return Image.asset(Images.gradientLineImage);
  }

  Widget buildFligthTimeTile(
      {String? departArrive,
      String? date,
      String? time,
      String? address,
      String? terminal,
      String? gate}) {
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
                date!,
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 10,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                time!,
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                address!,
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
                Strings.terminalStr,
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 12,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                terminal!,
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
                Strings.gateStr,
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 12,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                gate!,
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

  Widget buildViewLine({Size? size, double? height}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size!.height * 0.01,
      ),
      width: size.width / 1.2,
      height: height,
      color: Colorses.black,
    );
  }

  Widget commanText({String? title, String? subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
            color: Colorses.white,
            fontSize: 22,
            fontFamily: 'Inter-Medium',
          ),
        ),
        Text(
          subTitle!,
          style: TextStyle(
            color: Colorses.white,
            fontSize: 16,
            fontFamily: 'Inter-Regular',
          ),
        ),
      ],
    );
  }
}
