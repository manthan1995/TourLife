import 'package:flutter/material.dart';
import '../constant/colorses.dart';

class CommanBtn extends StatelessWidget {
  CommanBtn(
      {Key? key,
      this.text,
      this.onTap,
      required this.bgColor,
      required this.txtColor})
      : super(key: key);
  final String? text;
  void Function()? onTap;
  Color bgColor;
  Color txtColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Text(
              text!,
              style: TextStyle(
                  color: txtColor, fontFamily: 'Inter-SemiBold', fontSize: 18),
            )),
      ),
    );
  }
}
