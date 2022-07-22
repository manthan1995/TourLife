import 'package:flutter/material.dart';
import '../constant/colorses.dart';

class CommanBtn extends StatelessWidget {
  CommanBtn({Key? key, this.text, this.onTap}) : super(key: key);
  final String? text;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}
