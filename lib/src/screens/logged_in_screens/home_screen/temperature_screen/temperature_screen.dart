import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/loading_widget/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final fb = FirebaseDatabase.instance;
  final List<String> temperatureList = [];
  final List<String> timeList = [];

  _readData() async {
    for (var i = 0; i < 9; i++) {
      final ref = fb.ref().child('data/temperature/temperature $i');
      final temperature = await ref.child('temperature').get();
      final time = await ref.child('time').get();
      temperatureList.add(temperature.value.toString());
      timeList.add(time.value.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBarWidget.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder(
      future: _readData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            temperatureList == [] ||
            timeList == []) {
          return const Loading();
        }
        List<_TempData> data = [
          _TempData("00:00", double.parse(temperatureList[0])),
          _TempData("03:00", double.parse(temperatureList[1])),
          _TempData("06:00", double.parse(temperatureList[2])),
          _TempData("09:00", double.parse(temperatureList[3])),
          _TempData("12:00", double.parse(temperatureList[4])),
          _TempData("15:00", double.parse(temperatureList[5])),
          _TempData("18:00", double.parse(temperatureList[6])),
          _TempData("21:00", double.parse(temperatureList[7])),
          _TempData("24:00", double.parse(temperatureList[8])),
        ];

        return DefaultBackgroundWidget.basicColor(
          context: context,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: _buildSfCartesianChart(data),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSfCartesianChart(List<_TempData> data) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'Temperature List'),
      // legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<_TempData, String>>[
        LineSeries<_TempData, String>(
          dataSource: data,
          xValueMapper: (_TempData temperature, _) => temperature.hour,
          yValueMapper: (_TempData temperature, _) => temperature.temp,
          name: 'Temp',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}

class _TempData {
  _TempData(this.hour, this.temp);

  final String hour;
  final double temp;
}
