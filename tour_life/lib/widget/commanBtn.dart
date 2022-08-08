import 'package:flutter/material.dart';

class CommanBtn extends StatelessWidget {
  CommanBtn(
      {Key? key,
      this.text,
      this.onTap,
      required this.bgColor,
      required this.padding,
      required this.txtColor})
      : super(key: key);
  final String? text;
  void Function()? onTap;
  Color bgColor;
  Color txtColor;
  EdgeInsetsGeometry padding;
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
            padding: padding,
            child: Text(
              text!,
              style: TextStyle(
                  color: txtColor, fontFamily: 'Inter-SemiBold', fontSize: 18),
            )),
      ),
    );
  }
}
