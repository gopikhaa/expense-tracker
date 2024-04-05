import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Chart extends StatelessWidget {
  const Chart({required this.dataMap, Key? key, required this.name})
      : super(key: key);
  final dataMap;
  final name;

  @override
  Widget build(BuildContext context) {
    dataMap.remove('total');
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(microseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 1.5,
      colorList: [
        Colors.green,
        Colors.blue,
        Colors.orange,
        Colors.purple,
        Colors.brown,
        Color(0xFFE57373),
        Color(0xFFF06292),
        Color(0xFFBA68C8),
        Color(0xFF9575CD),
        Color(0xFF7986CB),
        Color(0xFF64B5F6),
        Color(0xFF4FC3F7),
        Color(0xFF4DD0E1),
        Color(0xFF4DB6AC),
        Color(0xFF81C784),
        Color(0xFFAED581),
        Color(0xFFFF8A65),
        Color(0xFFD4E157),
        Color(0xFFFFD54F),
        Color(0xFFFFB74D),
        Color(0xFFA1887F),
        Color(0xFF90A4AE),
        Color(0xFFB0BEC5),
        Color(0xFF78909C),
        Color(0xFF455A64),
      ],
      initialAngleInDegree: 0,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(showLegends: false),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
