import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/asset_image_widget/asset_image_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/button_widget/button_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          _buildText(context),
          const Spacer(),
          _buildCard(context),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Create your account',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Join us you\nplant fanatic',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNameField(),
                  const SizedBox(height: 20),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 20),
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: nameController,
          validator: validateName,
          decoration: const InputDecoration(
            icon: Icon(Icons.contacts),
            hintText: 'What is your name?',
            labelText: 'Name',
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: emailController,
          validator: validateEmail,
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'What is your email address?',
            labelText: 'Email',
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: passwordController,
          validator: validatePassword,
          decoration: const InputDecoration(
            icon: Icon(Icons.password),
            hintText: 'What is your password?',
            labelText: 'Password',
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ButtonWidget.basicStyle(
      context: context,
      title: 'Create an account',
      backgroundColor: Colors.deepOrangeAccent.shade200,
      textColor: Colors.white,
      onPressItem: () {
        register();
      },
    );
  }

  Future register() async {
    if (_key.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then(
          (value) async {
            User? user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .set(
              {
                'userId': user?.uid,
                'userName': nameController.text,
                'userEmail': emailController.text,
                'userPassword': passwordController.text,
              },
            );
          },
        );
        RoutesHelper.goToIndex(context);
        errorMessage = '';
      } on FirebaseAuthException catch (error) {
        errorMessage = error.message!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }
}

String? validateName(String? formName) {
  if (formName == null || formName.isEmpty) {
    return 'Name is required';
  }
  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(formEmail)) {
    return 'Invalid E-mail address format';
  }
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required';
  }
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(formPassword)) {
    return '''
    Password must be at least 8 characters, 
    include an uppercase letter, 
    number and symbol.
    ''';
  }
  return null;
}
