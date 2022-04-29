import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/user_model/user_model.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/services_helper/user_services/user_services.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/button_widget/button_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/loading_widget/loading_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String errorMessage = '';
  String currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();
  late UserModel userModel;

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
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _buildUserInfo('User Name: ${userModel.userName}'),
              const SizedBox(height: 10),
              _buildUserInfo('Email: ${userModel.userEmail}'),
              const Spacer(),
              _buildLogoutButton(),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(String title) {
    return SizedBox(
      height: 60,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ButtonWidget.basicStyle(
      context: context,
      title: 'Logout',
      onPressItem: () async {
        logout();
      },
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
