import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/route_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_top_snack_bar.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/home_screen/humidity_screen/humidity_screen.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/home_screen/temperature_screen/temperature_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fb = FirebaseDatabase.instance;
  static dynamic l;
  static dynamic g;
  static dynamic temperature;
  static dynamic humidity;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('realTimeData');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const Spacer(),
          _buildText(),
          const SizedBox(height: 10),
          _buildTemperature(ref),
          const SizedBox(height: 10),
          _buildHumidity(ref),
          const SizedBox(height: 10),
          _buildCheckTempBtn(context),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Row(
        children: const [
          Text(
            'Real Time Monitoring',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: _buildCard(
            title: '$temperature ??C',
            icon: FontAwesomeIcons.temperatureHalf,
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
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: _buildCard(
            title: '$humidity %',
            icon: FontAwesomeIcons.droplet,
            color: Colors.blue,
            onTapItem: () {
              RoutesHelper.pushScreen(context, const HumidityScreen());
            },
          ),
        );
      },
    );
  }

  Widget _buildCheckTempBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (double.parse(temperature) >= 30) {
          CustomTopSnackBar.showError(
            context: context,
            errorMessage:
                'Warning: The temperature is too high for plants to grow.',
          );
        } else {
          CustomTopSnackBar.showInfo(
            context: context,
            message: 'This temperature is suitable for plant growth.',
          );
        }
      },
      child: const Text(
        'Click me to know is the current temp suitable for planting?',
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Icon(icon ?? Icons.home, size: 45, color: color ?? Colors.black),
              const SizedBox(width: 20),
              _buildInfoColumn(title),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String? title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text(
          title ?? 'Card',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Click me for more info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
      ],
    );
  }
}
