import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/logged_in_screens/home_screen/humidity_screen/humidity_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/logged_in_screens/home_screen/temperature_screen/temperature_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fb = FirebaseDatabase.instance;
  var l;
  var g;
  var k;
  var temperature;
  var humidity;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('realTimeData');
    return Column(
      children: [
        const Spacer(flex: 2),
        _buildTemperature(ref),
        const Spacer(),
        _buildHumidity(ref),
        const Spacer(),
      ],
    );
  }

  Widget _buildTemperature(DatabaseReference ref) {
    return FirebaseAnimatedList(
      query: ref,
      shrinkWrap: true,
      itemBuilder: (context, snapshot, animation, index) {
        var v = snapshot.value.toString();
        g = v.replaceAll(RegExp('{|}|humidity: |temperature: '), '');
        g.trim();
        l = g.split(',');
        temperature = l[0];
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: _buildCard(
            title: '$temperature C',
            icon: Icons.thermostat,
            color: Colors.red,
            onTapItem: () {
              RoutesHelper.pushScreen(context, const TemperatureScreen());
            },
          ),
        );
      },
    );
  }

  Widget _buildHumidity(DatabaseReference ref) {
    return FirebaseAnimatedList(
      query: ref,
      shrinkWrap: true,
      itemBuilder: (context, snapshot, animation, index) {
        var v = snapshot.value.toString();
        g = v.replaceAll(RegExp('{|}|humidity: |temperature: '), '');
        g.trim();
        l = g.split(',');
        humidity = l[1];
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: _buildCard(
            title: '$humidity %',
            icon: Icons.opacity,
            color: Colors.blue,
            onTapItem: () {
              RoutesHelper.pushScreen(context, const HumidityScreen());
            },
          ),
        );
      },
    );
  }

  Widget _buildCard({
    String? title,
    IconData? icon,
    Color? color,
    Function()? onTapItem,
  }) {
    return InkWell(
      onTap: onTapItem,
      child: SizedBox(
        height: 80,
        child: Card(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Icon(icon ?? Icons.home, size: 45, color: color ?? Colors.black),
              const SizedBox(width: 20),
              Text(
                title ?? 'Card',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 30, color: Colors.black),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
