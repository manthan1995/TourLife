import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:ui' as ui;
import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/preferences_key.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';
import 'all_data/model/all_data_model.dart';

class HotelScreen extends StatefulWidget {
  String profilePic;
  String coverPic;
  String date;
  String month;
  String userName;
  String location;
  int gigId;
  int userId;
  HotelScreen(
      {Key? key,
      required this.gigId,
      required this.date,
      required this.month,
      required this.coverPic,
      required this.profilePic,
      required this.userName,
      required this.location,
      required this.userId})
      : super(key: key);

  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? mapMarker;
  LatLng? startLocation;
  late AllDataModel prefData;
  late Hotels hotelData;

  @override
  void initState() {
    var data = preferences.getString(Keys.allReponse);
    prefData = AllDataModel.fromJson(jsonDecode(data!));

    for (int i = 0; i < prefData.result!.hotels!.length; i++) {
      if (widget.gigId == prefData.result!.hotels![i].gigId &&
          widget.userId == prefData.result!.hotels![i].userId) {
        hotelData = (prefData.result!.hotels![i]);
      }
    }
    startLocation = LatLng(
        double.parse(hotelData.direction.toString().split(',').first),
        double.parse(hotelData.direction.toString().split(',').last));

    print(hotelData.address);
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
        await getBytesFromAsset(Images.hotelMarkerImage, 150);

    setState(() {
      markers.add(Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation!, //position of marker
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
        text: Strings.hotelStr,
      ),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                CommanHeaderBg(
                  title: widget.userName,
                  subTitle: widget.location,
                  profilePic: widget.profilePic,
                  coverPic: widget.coverPic,
                  date: widget.date,
                  month: widget.month,
                ),
                buildForGroundPart(size: size)
              ],
            ),
          ],
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
            buildDetailCard(size: size),
            SizedBox(
              height: size.height * 0.02,
            ),
            buildTravellerPart(size: size),
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
              Images.hotelFullImage,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelData.hotelName!,
                    style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        color: Colorses.red,
                        fontSize: 17),
                  ),
                  Text(
                    hotelData.address!,
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
                      target: startLocation!,
                      zoom: 14,
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
                          openMap(hotelData.direction!);
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
                        onTap: () {
                          _launchInBrowser(Uri.parse(hotelData.website!));
                        },
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
                          _makePhoneCall(hotelData.number!);
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
                ],
              ),
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
                          Strings.wifiStr,
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(hotelData.wifiPaidFor!
                      ? Images.doneImage
                      : Images.unconfirmedImage),
                  Text(
                    hotelData.wifiPaidFor! ? Strings.yesStr : Strings.noStr,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.roomBuyOutStr,
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.red,
                        fontSize: 14),
                  ),
                  Text(
                    hotelData.roomBuyout!,
                    style: TextStyle(
                        fontFamily: 'Inter-Medium',
                        color: Colorses.black,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTravellerPart({Size? size}) {
    return Center(
      child: Container(
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
