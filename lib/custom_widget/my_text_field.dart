import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText, labelText;
  TextStyle? hintStyle, labelStyle;
  bool? field;
  Color? fillColor;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Widget? SuffixIcon,PrefixIcon;
  bool obscureText;
  void Function(String)? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        suffixIcon: SuffixIcon,
        prefixIcon: PrefixIcon,
        filled: field,
        fillColor: fillColor,
      ),
      onChanged: onChanged,
    );
  }

  MyTextField({
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.field,
    this.fillColor,
    this.controller,
    this.keyboardType,
    this.SuffixIcon,
    this.PrefixIcon,
    this.obscureText = false,
    this.onChanged ,
  });
}
