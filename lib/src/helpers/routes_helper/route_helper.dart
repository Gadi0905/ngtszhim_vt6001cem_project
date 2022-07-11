import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/route_constants.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/index_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/welcome/welcome_screen.dart';

class RoutesHelper {
  static getCustomRoutes() {
    return <String, WidgetBuilder>{
      RoutesConstants.welcome: (context) => const WelcomeScreen(),
      RoutesConstants.index: (context) => const IndexScreen(),
    };
  }

  // go to a specific page
  static pushScreen(context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  // back to previous page
  static pop(context) {
    Navigator.pop(context);
  }

  // back to first page
  static popToRoot(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // go to a specific page and remove all previous page
  static pushAndRemoveUntil(context, routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
        arguments: arguments);
  }

  // go to a welcome page
  static goToWelcome(context) {
    pushAndRemoveUntil(context, RoutesConstants.welcome);
  }

  // go to a index page
  static goToIndex(context) {
    pushAndRemoveUntil(context, RoutesConstants.index);
  }
}
