import 'package:flutter/material.dart';

class CustomBackground {
  // the basic color of background widget
  static basicColor({
    Color? defaultColor,
    Color? topColor,
    Color? middleColor,
    Color? bottomColor,
    Widget? child,
    required BuildContext context,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: defaultColor ?? Colors.black38,
      child: child,
    );
  }
}
