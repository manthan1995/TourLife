import 'package:flutter/material.dart';
import 'package:tour_life/constant/colorses.dart';

class CommanHeader extends StatelessWidget {
  const CommanHeader({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.05),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        color: Colorses.black,
        boxShadow: [
          BoxShadow(
            color: Colorses.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: const Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      width: size.width,
      height: size.height * 0.15,
      child: Text(
        text!,
        style: TextStyle(
            color: Colorses.white, fontFamily: 'Inter-Bold', fontSize: 20),
      ),
    );
  }
}
