import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:flutter_pothole_front/widgets/skeleton.dart';
import 'package:provider/provider.dart';

import '../../../utils/loading_provider.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<IsLoadingState>(context).isLoading) {
      return const Center(
          child: Skeleton(width: 250, height: 250, opacity: 0.05));
    } else {
      return SizedBox(
        height: 300,
        child: Stack(
          children: <Widget>[
            PieChart(PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 100,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            )),
            Positioned.fill(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  height: defaultPadding,
                ),
              ],
            ))
          ],
        ),
      );
    }
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: taskData[0].iconColor,
    value: taskData[0].count.toDouble(),
    showTitle: false,
    radius: 38,
  ),
  PieChartSectionData(
    color: taskData[1].iconColor,
    value: taskData[1].count.toDouble(),
    showTitle: false,
    radius: 32,
  ),
  PieChartSectionData(
    color: taskData[2].iconColor,
    value: taskData[2].count.toDouble(),
    showTitle: false,
    radius: 25,
  ),
];
