import 'package:flutter/material.dart';

class InformationStat extends StatelessWidget {
  const InformationStat({Key? key, required this.dataMap, required this.colors})
      : super(key: key);

  final Map<String, double> dataMap;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: dataMap.entries.toList().asMap().entries.map((entry) {
          final int index = entry.key;
          final MapEntry<String, double> dataEntry = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dataEntry.key,
                    style: TextStyle(
                      color: colors[index],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${dataEntry.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: colors[index] ,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
