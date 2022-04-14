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
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.circle_notifications,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
      elevation: 0.0,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor ?? Colors.lightBlueAccent,
    );
  }
}
