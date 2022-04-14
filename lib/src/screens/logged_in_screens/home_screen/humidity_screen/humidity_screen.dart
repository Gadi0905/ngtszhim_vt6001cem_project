import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({Key? key}) : super(key: key);

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarWidget.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<_HumidityData> data = [
      _HumidityData('00:00', 65),
      _HumidityData('03:00', 64),
      _HumidityData('06:00', 55),
      _HumidityData('09:00', 54),
      _HumidityData('12:00', 54),
      _HumidityData('15:00', 53),
      _HumidityData('18:00', 58),
      _HumidityData('21:00', 62),
      _HumidityData('24:00', 65),
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
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Humidity List'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_HumidityData, String>>[
                LineSeries<_HumidityData, String>(
                  dataSource: data,
                  xValueMapper: (_HumidityData humidity, _) => humidity.hour,
                  yValueMapper: (_HumidityData humidity, _) =>
                      humidity.humidity,
                  name: 'Humidity',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HumidityData {
  _HumidityData(this.hour, this.humidity);

  final String hour;
  final double humidity;
}
