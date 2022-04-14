import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.isFullScreen = true}) : super(key: key);
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    // check if it is full screen
    if (isFullScreen) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return const Center(child: CircularProgressIndicator());
  }
}
