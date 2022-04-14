import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key, required this.errorMessage, this.appBar})
      : super(key: key);
  final String errorMessage;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
