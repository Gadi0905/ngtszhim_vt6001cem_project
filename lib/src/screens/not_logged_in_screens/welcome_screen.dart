import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/asset_image_widget/asset_image_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/button_widget/button_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/not_logged_in_screens/login_screen/login_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/not_logged_in_screens/registration_screen/registration_screen.dart';

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
      child: Stack(
        children: [
          _buildBackgroundImage(context),
          _buildItem(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.3,
        child: AssetImageWidget.basicImage(
          context: context,
          image: 'wallpaper.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          _buildWelcomeText(context),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'The best\napp for\nyour plants',
            style: TextStyle(
              color: Colors.white,
              fontSize: 65,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ButtonWidget.basicStyle(
          context: context,
          backgroundColor: Colors.deepOrangeAccent.shade200,
          textColor: Colors.white,
          title: 'Getting started',
          onPressItem: () {
            RoutesHelper.pushScreen(context, const RegistrationScreen());
          },
        ),
        const SizedBox(height: 20),
        ButtonWidget.basicStyle(
          context: context,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          title: 'Login',
          onPressItem: () {
            RoutesHelper.pushScreen(context, const LoginScreen());
          },
        ),
      ],
    );
  }
}
