import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.question,
    this.onPressItem,
    this.title,
    this.textColor,
    this.questionColor,
  }) : super(key: key);
  final String? question;
  final Function()? onPressItem;
  final String? title;
  final Color? textColor;
  final Color? questionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question ?? 'question',
          style: TextStyle(
            color: questionColor ?? Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPressItem,
          child: Text(
            title ?? 'title',
            style: TextStyle(
              color: textColor ?? Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
