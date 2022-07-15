import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class CarJourney extends StatefulWidget {
  List<Schedule>? carDataList = [];

  int? id;
  CarJourney({Key? key, this.id, this.carDataList}) : super(key: key);

  @override
  _CarJourneyState createState() => _CarJourneyState();
}

class _CarJourneyState extends State<CarJourney> {
  late Map<String, dynamic> prefData;
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? mapMarker;
  LatLng? startLocation;
  LatLng? endLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    print(widget.carDataList![widget.id!].departLocation);
    print(widget.carDataList![widget.id!].arrivalLocation);

    // TODO: implement initState
    // var data = preferences.getString(Keys.allReponse);
    // prefData = jsonDecode(data!);
    // prefData["result"]["schedule"][widget.id]["depart_location"];
    startLocation = LatLng(
        double.parse(widget.carDataList![widget.id!].departLatLong
            .toString()
            .split(',')
            .first),
        double.parse(widget.carDataList![widget.id!].departLatLong
            .toString()
            .split(',')
            .last));
    endLocation = LatLng(
        double.parse(widget.carDataList![widget.id!].arrivalLatLong
            .toString()
            .split(',')
            .first),
        double.parse(widget.carDataList![widget.id!].arrivalLatLong
            .toString()
            .split(',')
            .last));
    super.initState();
    setState(() {
      addMarkers();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
        await getBytesFromAsset(Images.departMarkerImage, 250);

    final Uint8List markerIconEnd =
        await getBytesFromAsset(Images.arriveMarkerImage, 250);

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.carJourneyStr,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colorses.white,
          child: Column(
            children: [
              Stack(
                children: [
                  const CommanHeaderBg(),
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
            "Tuesday. May 30, 2022",
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
          buildDriverCard(size: size),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commanText(title: widget.carDataList![widget.id!].departLocation),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Images.carHorizontalImage),
                Text(
                  "21 Min",
                  style: TextStyle(
                    color: Colorses.white,
                    fontSize: 14,
                    fontFamily: 'Inter-Medium',
                  ),
                ),
              ],
            ),
          ),
        ),
        commanText(title: widget.carDataList![widget.id!].arrivalLocation),
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
          Container(
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: GoogleMap(
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: markers,
                  onMapCreated: _onMapCreated,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: startLocation!,
                    zoom: 16,
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
                  children: [
                    Column(
                      children: [Image.asset(Images.carVerticalImage)],
                    ),
                    SizedBox(
                      width: size.width * 0.65,
                      child: Column(
                        children: [
                          buildFligthTimeTile(departArrive: Strings.departStr),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          buildFligthTimeTile(departArrive: Strings.arriveStr),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
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

  Widget buildDriverCard({Size? size}) {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.driverStr,
                      style: TextStyle(
                        color: Colorses.black,
                        fontSize: 13,
                        fontFamily: 'Inter-Medium',
                      ),
                    ),
                    Text(
                      "Mike McCall (Alpha Instinct)",
                      style: TextStyle(
                        color: Colorses.red,
                        fontSize: 14,
                        fontFamily: 'Inter-SemiBold',
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                Images.callImage,
              ),
              SvgPicture.asset(
                Images.msgImage,
              ),
            ],
          ),
        ));
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

  Widget buildFligthTimeTile({String? departArrive}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                "Cleveland Hopkins \nInternational",
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
            children: [
              Text(
                "Local Time",
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
                  fontFamily: 'Inter-Regular',
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

  Widget commanText({String? title}) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title!,
              style: TextStyle(
                color: Colorses.white,
                fontSize: 16,
                fontFamily: 'Inter-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
