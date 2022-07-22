import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';

class CommanHeaderBg extends StatelessWidget {
  CommanHeaderBg({Key? key, required this.title, required this.subTitle})
      : super(key: key);
  String title;
  String subTitle;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: size.width,
          height: size.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            color: Colorses.black,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Image.asset(
              Images.gigBgImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 50, left: 15, right: 15),
          child: ListTile(
            leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(Images.apicImage)),
            trailing: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SvgPicture.asset(
                  Images.calendarImage,
                  width: 80,
                  height: 60,
                  fit: BoxFit.fill,
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    " 24\nJUN",
                    style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        color: Colorses.red,
                        fontSize: 11),
                  ),
                )
              ],
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(
                  fontFamily: 'Inter-Light',
                  color: Colorses.white,
                  fontSize: 16),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Inter-Medium',
                  color: Colorses.white,
                  fontSize: 22),
            ),
          ),
        )
      ],
    );
  }
}
