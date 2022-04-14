import 'package:flutter/material.dart';

class DefaultBackgroundWidget {
  // the basic color of background widget
  static basicColor({
    Color? topColor,
    Color? middleColor,
    Color? bottomColor,
    Widget? child,
    required BuildContext context,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            topColor ?? Colors.lightBlueAccent,
            middleColor ?? Colors.lightBlue,
            bottomColor ?? Colors.blue
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
