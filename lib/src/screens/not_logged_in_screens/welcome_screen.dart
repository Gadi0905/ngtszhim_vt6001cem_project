import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/asset_image_widget/asset_image_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/button_widget/button_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/not_logged_in_screens/login_screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBarWidget.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return DefaultBackgroundWidget.basicColor(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          _buildWelcomeText(context),
          const Spacer(),
          AssetImageWidget.basicImage(
            context: context,
            image: 'planting.png',
            width: 300,
            height: 300,
          ),
          const Spacer(),
          _buildButton(context),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Welcome to Planting Prince',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'A simple app to help you grow plants',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ButtonWidget.basicStyle(
      context: context,
      title: 'Getting started',
      onPressItem: () {
        RoutesHelper.pushScreen(context, const LoginScreen());
      },
    );
  }
}
