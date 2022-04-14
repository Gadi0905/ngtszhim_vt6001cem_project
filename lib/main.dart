import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/logged_in_screens/index_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/not_logged_in_screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return MaterialApp(
        title: 'Planting Prince',
        routes: RoutesHelper.getCustomRoutes(),
        home: const IndexScreen(), // initial screen
      );
    } else {
      return MaterialApp(
        title: 'Planting Prince',
        routes: RoutesHelper.getCustomRoutes(),
        home: const WelcomeScreen(), // initial screen
      );
    }
  }
}
