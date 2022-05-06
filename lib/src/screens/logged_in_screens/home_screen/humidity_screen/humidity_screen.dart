import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/asset_image_widget/asset_image_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/loading_widget/loading_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({Key? key}) : super(key: key);

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  final fb = FirebaseDatabase.instance;
  final List<String> humidityList = [];
  final List<String> timeList = [];

  _readData() async {
    for (var i = 0; i < 9; i++) {
      final ref = fb.ref().child('data/humidity/humidity $i');
      final humidity = await ref.child('humidity').get();
      final time = await ref.child('time').get();
      humidityList.add(humidity.value.toString());
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
            humidityList == [] ||
            timeList == []) {
          return const Loading();
        }
        List<_HumData> data = [
          _HumData('00:00', double.parse(humidityList[0])),
          _HumData('03:00', double.parse(humidityList[1])),
          _HumData('06:00', double.parse(humidityList[2])),
          _HumData('09:00', double.parse(humidityList[3])),
          _HumData('12:00', double.parse(humidityList[4])),
          _HumData('15:00', double.parse(humidityList[5])),
          _HumData('18:00', double.parse(humidityList[6])),
          _HumData('21:00', double.parse(humidityList[7])),
          _HumData('24:00', double.parse(humidityList[8])),
        ];

        return DefaultBackgroundWidget.basicColor(
          context: context,
          child: Stack(
            children: [
              _buildBackgroundImage(context),
              _buildItem(data),
            ],
          ),
        );
      },
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

  Widget _buildItem(List<_HumData> data) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildText(),
            _buildCard(data),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return Row(
      children: const [
        Text(
          'Humidity Chart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(List<_HumData> data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 10,
      child: _buildSfCartesianChart(data),
    );
  }

  Widget _buildSfCartesianChart(List<_HumData> data) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'Humidity List'),
      // legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<_HumData, String>>[
        LineSeries<_HumData, String>(
          dataSource: data,
          xValueMapper: (_HumData humidity, _) => humidity.hour,
          yValueMapper: (_HumData humidity, _) => humidity.hum,
          name: 'Hum',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}

class _HumData {
  _HumData(this.hour, this.hum);

  final String hour;
  final double hum;
}
