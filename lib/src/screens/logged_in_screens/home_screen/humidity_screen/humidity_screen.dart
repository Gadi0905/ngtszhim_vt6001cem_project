import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({Key? key}) : super(key: key);

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  final fb = FirebaseDatabase.instance;
  var l;
  var g;
  var k;
  var temperature;
  var humidity;
  var time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarWidget.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final ref = fb.ref().child('data/humidity');
    return DefaultBackgroundWidget.basicColor(
      context: context,
      child: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v = snapshot.value.toString();
          g = v.replaceAll(RegExp("{|}|humidity: |temperature: |time: "), "");
          g.trim();
          l = g.split(',');
          humidity = l[0];
          time = l[1];
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: _buildCard(
              title: "$humidity %",
              subTitle: "Time: $time",
              icon: Icons.opacity,
              color: Colors.blue,
              onTapItem: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    String? title,
    String? subTitle,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    title ?? 'title',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subTitle ?? 'subTitle',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
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
