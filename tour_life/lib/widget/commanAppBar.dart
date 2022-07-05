import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colorses.dart';
import '../constant/images.dart';

PreferredSizeWidget buildAppbar({String? text, required BuildContext context}) {
  Size size = MediaQuery.of(context).size;

  return AppBar(
    backgroundColor: Colorses.black,
    centerTitle: true,
    leadingWidth: 70,
    toolbarHeight: size.height * 0.1,
    leading: Container(
      padding: EdgeInsets.only(left: 25),
      child: SvgPicture.asset(
        Images.backbtnImage,
      ),
    ),
    title: Text(
      text!,
      style: TextStyle(
        color: Colorses.white,
        fontSize: 20,
        fontFamily: 'Inter-Bold',
      ),
    ),
  );
}
