import 'package:flutter/material.dart';

class ButtonWidget {
  // the basic style of button
  static basicStyle({
    required BuildContext context,
    required Function() onPressItem,
    String? title,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: onPressItem,
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              return 10;
            },
          ),
          backgroundColor:
              MaterialStateProperty.all(backgroundColor ?? Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
        child: Text(
          title ?? 'Button',
          style: TextStyle(
            color: textColor ?? Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
