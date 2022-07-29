import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';
import 'package:flutter_pothole_front/pages/info_page/components/statistic_card_info.dart';
import 'package:flutter_pothole_front/pages/info_page/components/statistic_chart.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';


class Statistic extends StatelessWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).home_statistic_card_title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Divider(),
            const SizedBox(
              height: defaultPadding*2,
            ),
            const Chart(),
            StatisticCardInfo(
              title: S.of(context).home_task_card_1,
              info: taskData[0],
            ),
            StatisticCardInfo(
              title: S.of(context).home_task_card_2,
              info: taskData[1],
            ),
            StatisticCardInfo(
              title: S.of(context).home_task_card_3,
              info: taskData[2],
            ),
          ],
        ),
      ),
    );
  }
}
