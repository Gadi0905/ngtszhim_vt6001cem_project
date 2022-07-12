import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_appbar.dart';

// import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ObservatoryScreen extends StatelessWidget {
  const ObservatoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basicColor(
        backButtonColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: const WebView(
        initialUrl: 'https://www.hko.gov.hk/tc/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
