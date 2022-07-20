import 'package:flutter/material.dart';
import '../constant/colorses.dart';

class CommanBtn extends StatelessWidget {
  const CommanBtn({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colorses.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: Text(
            text!,
            style: TextStyle(
                color: Colorses.red, fontFamily: 'Inter-Bold', fontSize: 18),
          )),
    );
  }
}
