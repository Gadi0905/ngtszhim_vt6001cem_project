import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/route_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_appbar.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_background.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_button.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_image_asset.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/login/login_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/registration/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomBackground.basicColor(
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
    return const Positioned.fill(
      child: Opacity(
        opacity: 0.3,
        child: CustomImageAsset(
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildWelcomeText(context),
          _buildButton(context),
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
        CustomButton(
          backgroundColor: Colors.deepOrangeAccent.shade200,
          textColor: Colors.white,
          title: 'Getting started',
          onPressItem: () {
            RoutesHelper.pushScreen(context, const RegistrationScreen());
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
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
