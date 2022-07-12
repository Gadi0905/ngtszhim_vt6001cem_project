import 'package:flutter/material.dart';

class CustomAppBar {
  // the basic color of app bar widget
  static basicColor({
    String? title,
    Color? backgroundColor,
    Color? backButtonColor,
    bool? automaticallyImplyLeading,
  }) {
    return AppBar(
      iconTheme: IconThemeData(color: backButtonColor),
      title: Text(title ?? ''),
      elevation: 0.0,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor ?? Colors.transparent,
    );
  }
}
