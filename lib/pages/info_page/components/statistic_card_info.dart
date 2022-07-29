import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';
import 'package:flutter_pothole_front/utils/constants.dart';

class StatisticCardInfo extends StatelessWidget {
  const StatisticCardInfo({
    Key? key,
    required this.title,
    required this.info
  }) : super(key: key);

  final String title;
  final TaskCardInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: info.containerColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(info.icon, color: info.iconColor,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${title}".toUpperCase(), style: Theme.of(context).textTheme.caption),
                  Text(
                      "${info.count}", style:const TextStyle(height: 2)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
