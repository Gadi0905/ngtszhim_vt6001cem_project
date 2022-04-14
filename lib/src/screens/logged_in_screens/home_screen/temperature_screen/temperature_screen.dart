import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarWidget.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<_TempData> data = [
      _TempData('00:00', 25),
      _TempData('03:00', 24),
      _TempData('06:00', 15),
      _TempData('09:00', 14),
      _TempData('12:00', 14),
      _TempData('15:00', 13),
      _TempData('18:00', 18),
      _TempData('21:00', 22),
      _TempData('24:00', 25),
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
  }

  Widget _buildSfCartesianChart(List<_TempData> data) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'Temperature List'),
      legend: Legend(isVisible: true),
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
