import 'package:flutter/material.dart';
import 'package:tour_life/constant/strings.dart';

import '../constant/colorses.dart';

class CommanTextField extends StatelessWidget {
  CommanTextField(
      {Key? key,
      this.hintText,
      this.obscureText,
      this.suffixIcon,
      this.keyboardType,
      this.controller,
      this.validator})
      : super(key: key);
  bool? obscureText;
  String? hintText;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.all(20.0),
          filled: true,
          hintStyle: TextStyle(color: Colorses.white),
          hintText: hintText,
          fillColor: Colorses.red),
      autofocus: false,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      style: TextStyle(color: Colorses.white, fontFamily: 'Inter-Medium'),
    );
  }
}
