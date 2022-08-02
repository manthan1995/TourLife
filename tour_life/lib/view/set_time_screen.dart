import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import '../constant/colorses.dart';
import '../constant/date_time.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class SetTimeScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String userName;
  String location;
  List<Schedule>? setTimeDataList = [];
  String date;
  String month;
  int? id;
  SetTimeScreen(
      {Key? key,
      this.id,
      this.setTimeDataList,
      required this.date,
      required this.coverPic,
      required this.profilePic,
      required this.month,
      required this.userName,
      required this.location})
      : super(key: key);

  @override
  _SetTimeScreenState createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  late Map<String, dynamic> prefData;
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? mapMarker;
  LatLng? startLocation;
  LatLng? endLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    startLocation = LatLng(
        double.parse(widget.setTimeDataList![widget.id!].venue
            .toString()
            .split(',')
            .first),
        double.parse(widget.setTimeDataList![widget.id!].venue
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
        await getBytesFromAsset(Images.venueMarkerImage, 150);

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
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: "Set Time",
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
        ],
      ),
    );
  }

  Widget buildSchedulePart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.settimeImage),
              Text(
                "1 h",
                style: TextStyle(
                  color: Colorses.white,
                  fontSize: 14,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ],
          ),
        ),
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
                buildFligthTimeTile(
                  startFinish: Strings.startStr,
                  date: getDate(
                      dates: widget.setTimeDataList![widget.id!].departTime),
                  time: getTime(
                      times: widget.setTimeDataList![widget.id!].departTime),
                ),
                buildViewLine(size: size, height: 1),
                buildFligthTimeTile(
                    startFinish: Strings.finishStr,
                    date: getDate(
                        dates: widget.setTimeDataList![widget.id!].arrivalTime),
                    time: getTime(
                        times: widget.setTimeDataList![widget.id!].departTime)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGradientLine() {
    return Image.asset(Images.gradientLineImage);
  }

  Widget buildFligthTimeTile(
      {String? startFinish, String? date, String? time}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                startFinish!,
                style: TextStyle(
                  color: Colorses.red,
                  fontSize: 16,
                  fontFamily: 'Inter-Medium',
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                date!,
                style: TextStyle(
                  color: Colorses.black,
                  fontSize: 10,
                  fontFamily: 'Inter-Medium',
                ),
              ),
              Text(
                getTime(times: widget.setTimeDataList![widget.id!].departTime),
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

  // Widget commanText({String? title}) {
  //   return Expanded(
  //     child: Container(
  //       width: MediaQuery.of(context).size.width * 0.30,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(
  //             title!,
  //             style: TextStyle(
  //               color: Colorses.white,
  //               fontSize: 16,
  //               fontFamily: 'Inter-Regular',
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
