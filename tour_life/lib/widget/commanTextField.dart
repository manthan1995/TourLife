import 'package:flutter/material.dart';
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
          contentPadding: const EdgeInsets.all(22.0),
          filled: true,
          hintStyle: TextStyle(color: Colorses.red),
          hintText: hintText,
          fillColor: Colorses.white),
      autofocus: false,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      style: TextStyle(color: Colorses.red, fontFamily: 'Inter-Medium'),
    );
  }
}
