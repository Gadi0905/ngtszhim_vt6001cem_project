import 'package:flutter/material.dart';

class ButtonWidget {
  // the basic style of button
  static basicStyle({
    required BuildContext context,
    required Function() onPressItem,
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? fontSize,
    double? width,
    double? height,
  }) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: onPressItem,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          side: BorderSide(
            width: 3.0,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Text(
          title ?? 'Button',
          style: TextStyle(
            fontSize: fontSize ?? 16,
            color: textColor ?? Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
