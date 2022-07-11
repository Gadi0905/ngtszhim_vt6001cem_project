import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressItem,
    this.title,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.width,
    this.height,
  }) : super(key: key);
  final Function() onPressItem;
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
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
