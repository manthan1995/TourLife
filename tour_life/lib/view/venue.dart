import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_life/constant/preferences_key.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class Venue extends StatefulWidget {
  int id;
  Venue({Key? key, required this.id}) : super(key: key);

  @override
  _VenueState createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? mapMarker;
  LatLng? startLocation;
  late AllDataModel prefData;
  late Venues venueData;
  String? userName;

  @override
  void initState() {
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));

    for (int i = 0; i < prefData.result!.venues!.length; i++) {
      if (widget.id == prefData.result!.venues![i].gig) {
        venueData = (prefData.result!.venues![i]);
      }
    }
    for (int i = 0; i < prefData.result!.users!.length; i++) {
      if (venueData.user
          .toString()
          .contains(prefData.result!.users![i].id.toString())) {
        userName = prefData.result!.users![i].firstName.toString();
      }
    }

    startLocation = LatLng(
        double.parse(venueData.direction.toString().split(',').first),
        double.parse(venueData.direction.toString().split(',').last));

    print(userName);
    super.initState();
    addMarkers();
  }

  Set<Marker> markers = {};
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
    final Uint8List markerIcon =
        await getBytesFromAsset(Images.venueMarkerImage, 250);

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
        icon: BitmapDescriptor.fromBytes(markerIcon), //Icon for Marker
      ));
    });
  }

  openMap(String latlong) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latlong';
    final String encodedURl = Uri.encodeFull(googleUrl);

    if (await canLaunchUrl(Uri.parse(encodedURl))) {
      await launch(encodedURl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.venueStr,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colorses.red,
          child: Column(
            children: [
              Stack(
                children: [
                  CommanHeaderBg(
                    title: userName!,
                    subTitle: "dfs",
                  ),
                  buildForGroundPart(size: size)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForGroundPart({Size? size}) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          left: size!.height * 0.01,
          right: size.height * 0.01,
          top: size.height * 0.15,
        ),
        child: Column(
          children: [
            buildPinCard(size: size),
            buildMapCard(size: size),
            buildDestinationCard(size: size),
            buildDetailCard(size: size)
          ],
        ),
      ),
    );
  }

  Widget buildPinCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.01, horizontal: size.width * 0.03),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.pinImage,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venueData.venueName!,
                    style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        color: Colorses.red,
                        fontSize: 17),
                  ),
                  Text(
                    venueData.address!,
                    style: TextStyle(
                        fontFamily: 'Inter-Medium',
                        color: Colorses.black,
                        fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMapCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: GoogleMap(
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: markers,
                    onMapCreated: _onMapCreated,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      zoom: 14,
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
                  vertical: size!.height * 0.015,
                  horizontal: size.width * 0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          openMap(venueData.direction!);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Images.mapImage,
                            ),
                            Text(
                              Strings.directionStr,
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium',
                                  color: Colorses.red,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          _launchInBrowser(Uri.parse(venueData.website!));
                        }),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Images.webImage,
                            ),
                            Text(
                              Strings.websiteStr,
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium',
                                  color: Colorses.red,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // launch("tel://+1234567890");
                          _makePhoneCall(venueData.number!);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Images.callImage,
                            ),
                            Text(
                              Strings.callStr,
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium',
                                  color: Colorses.red,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildViewLine(size: size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            Strings.indoorStr,
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                color: Colorses.black,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SvgPicture.asset(venueData.indoor!
                              ? Images.doneImage
                              : Images.unconfirmedImage),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            venueData.indoor! ? Strings.yesStr : Strings.noStr,
                            style: TextStyle(
                                fontFamily: 'Inter-SemiBold',
                                color: Colorses.red,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            Strings.coveredStr,
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                color: Colorses.black,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SvgPicture.asset(venueData.covered!
                              ? Images.doneImage
                              : Images.unconfirmedImage),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            venueData.covered! ? Strings.yesStr : Strings.noStr,
                            style: TextStyle(
                                fontFamily: 'Inter-SemiBold',
                                color: Colorses.red,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            Strings.capacityStr,
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                color: Colorses.black,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            venueData.capacity!.toString(),
                            style: TextStyle(
                                fontFamily: 'Inter-SemiBold',
                                color: Colorses.red,
                                fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
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
            vertical: size!.height * 0.02, horizontal: size.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Venue Forecast",
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

  Widget buildDetailCard({Size? size}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02, horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                Strings.visaStr,
                style: TextStyle(
                    fontFamily: 'Inter-SemiBold',
                    color: Colorses.red,
                    fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                venueData.credentialCollection!,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.black,
                    fontSize: 12),
              ),
            ),
            buildViewLine(size: size),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                Strings.dressingRoomStr,
                style: TextStyle(
                    fontFamily: 'Inter-SemiBold',
                    color: Colorses.red,
                    fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                venueData.dressingRoom!,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colorses.black,
                    fontSize: 12),
              ),
            ),
            buildViewLine(size: size),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
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
                          Strings.hospitalityStr,
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                        Text(
                          venueData.hospitalityDetail!,
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              color: Colorses.black,
                              fontSize: 12),
                        ),
                        Text(
                          "• ${venueData.hospitalityEmail}",
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(venueData.hospitality!
                      ? Images.doneImage
                      : Images.unconfirmedImage),
                  Text(
                    venueData.hospitality!
                        ? Strings.confirmedStr
                        : Strings.unConfirmedStr,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.grey,
                        fontSize: 12),
                  )
                ],
              ),
            ),
            buildViewLine(size: size),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
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
                          Strings.cateringStr,
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                        Text(
                          venueData.catringDetail!,
                          style: TextStyle(
                              fontFamily: 'Inter-Medium',
                              color: Colorses.black,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(venueData.catring!
                      ? Images.doneImage
                      : Images.unconfirmedImage),
                  Text(
                    venueData.catring!
                        ? Strings.confirmedStr
                        : Strings.unConfirmedStr,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.grey,
                        fontSize: 12),
                  )
                ],
              ),
            ),
          ],
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
