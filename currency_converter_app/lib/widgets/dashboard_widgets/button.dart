import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final double width;
  final double height;

  const CustomButtonWidget({
    required this.onPressed,
    required this.text,
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.dp),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.dp,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
