import 'package:flutter/material.dart';

class DefaultAppBarWidget {
  // the basic color of app bar widget
  static basicColor({
    String? title,
    Color? backgroundColor,
    bool? automaticallyImplyLeading,
  }) {
    return AppBar(
      title: Text(title ?? ''),
      elevation: 0.0,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor ?? Colors.transparent,
    );
  }
}
