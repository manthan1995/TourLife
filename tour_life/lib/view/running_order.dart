import 'package:flutter/material.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/widget/commanAppBar.dart';
import 'package:tour_life/widget/commanHeaderBg.dart';

import '../constant/colorses.dart';

class RunningOrder extends StatefulWidget {
  const RunningOrder({Key? key}) : super(key: key);

  @override
  _RunningOrderState createState() => _RunningOrderState();
}

class _RunningOrderState extends State<RunningOrder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.runningOrderStr,
      ),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                CommanHeaderBg(),
                Container(
                  margin: EdgeInsets.only(
                    left: size.height * 0.01,
                    right: size.height * 0.01,
                    top: size.height * 0.15,
                  ),
                  height: size.height / 1.5,
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildListItem(size: size),
                        );
                      })),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListItem({Size? size}) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        color: Colorses.white,
      ),
      width: size!.width * 0.8,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                color: Colorses.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "11:00 PM 01:00 AM",
                style: TextStyle(
                    color: Colorses.white,
                    fontFamily: 'Inter-Medium',
                    fontSize: 15),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "LEE FOSS b2b JOHN SUMMIT",
              style: TextStyle(
                  color: Colorses.red,
                  fontFamily: 'Inter-Medium',
                  fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
