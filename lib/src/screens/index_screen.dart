import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/user_model.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/services_helper/user_services.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/route_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_appbar.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_background.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_loading.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/account_screen/account_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/home_screen/home_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/observatory_screen/observatory_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/planting_info_screen/planting_info_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/todo_list_screen/todo_list_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  String errorMessage = '';
  String currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();
  late UserModel userModel;

  final int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserServices.getUser(uid: currentUserID),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          errorMessage = snapshot.error.toString();
          return ErrorWidget(errorMessage);
        }
        if (snapshot.connectionState != ConnectionState.done ||
            !snapshot.hasData) {
          return const Loading();
        }
        userModel = snapshot.data!;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar.basicColor(),
          body: _buildBody(context),
          drawer: _buildDrawer(context),
          // bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.solidCircleUser, size: 70),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text('User Name: ${userModel.userName}',
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 20),
                      Text('User Email: ${userModel.userEmail}',
                          style: const TextStyle(fontSize: 12)),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.solidCircleUser),
            title: const Text('My Account'),
            onTap: () {
              RoutesHelper.pushScreen(context, const AccountScreen());
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.solidFileLines),
            title: const Text('Beginners Planting Tips'),
            onTap: () {
              RoutesHelper.pushScreen(context, const PlantingInfoScreen());
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.cloudSunRain),
            title: const Text('Weather'),
            onTap: () {
              RoutesHelper.pushScreen(context, const ObservatoryScreen());
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.listOl),
            title: const Text('Custom Todo List'),
            onTap: () {
              RoutesHelper.pushScreen(context, const TodoListScreen());
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            title: const Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomBackground(
      child: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      RoutesHelper.goToWelcome(context);
      errorMessage = '';
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
