import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import '../constant/colorses.dart';
import '../constant/images.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(27.6602292, 85.308027);
  BitmapDescriptor? mapMarker;
  LatLng startLocation = LatLng(27.6602292, 85.308027);

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
        await getBytesFromAsset(Images.hotelMarkerImage, 250);
    // BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(),
    //   "assets/venue_marker.png",
    // );

    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.fromBytes(markerIcon), //Icon for Marker
    ));

    setState(() {
      //refresh UI
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMarkers();
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
                const CommanHeaderBg(),
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
                    "The Standard Ibiza",
                    style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        color: Colorses.red,
                        fontSize: 17),
                  ),
                  Text(
                    "Carrer de Bartomeu Vicent Ramon, 9 Eivissa, Illes Balears, Spain",
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
                      target: _center,
                      zoom: 14,
                    ),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                        () => new EagerGestureRecognizer(),
                      ),
                    ].toSet()),
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
                      Column(
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
                      Column(
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
                      Column(
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
                          "Wi-fi paid for",
                          style: TextStyle(
                              fontFamily: 'Inter-SemiBold',
                              color: Colorses.red,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(Images.doneImage),
                  Text(
                    Strings.yesStr,
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
                    "Room buyout",
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        color: Colorses.red,
                        fontSize: 14),
                  ),
                  Text(
                    "N/A",
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
