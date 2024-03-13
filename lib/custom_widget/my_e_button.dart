import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  Widget Text;
  VoidCallback onPressed;
  Color? bgColor;
  Size? buttonSize;
  OutlinedBorder? shapeBorder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text,
      style: ElevatedButton.styleFrom(
        fixedSize: buttonSize,
        backgroundColor: bgColor,
        shape: shapeBorder,
      ),
    );
  }

  MyButton({
    required this.Text,
    required this.onPressed,
    required this.bgColor,
    required this.buttonSize,
    required this.shapeBorder,
  });
}
