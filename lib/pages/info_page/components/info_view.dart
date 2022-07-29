import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';
import 'package:flutter_pothole_front/models/task_grid.dart';
import 'package:flutter_pothole_front/pages/info_page/components/head.dart';
import 'package:flutter_pothole_front/pages/info_page/components/info_statistic_card.dart';
import 'package:flutter_pothole_front/pages/info_page/components/last_files.dart';
import 'package:flutter_pothole_front/pages/info_page/components/tasks_card.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../models/login_response.dart';
import '../../../models/task_statistic_response.dart';
import '../../../services/api_service.dart';
import '../../../services/shared_service.dart';
import '../../../utils/loading_provider.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  final List<TaskGrid> tasks = [];

  IsLoadingState isLoading = IsLoadingState();
  TaskStatistic? taskStatistic;
  bool isExecutor = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    taskStatistic = await APIService.getTaskStatistic();
    // User? user = await SharedService.getUserDetails();

    taskData[0].count = taskStatistic?.countCurrentTasks != null
        ? taskStatistic?.countCurrentTasks.toInt()
        : 0;
    taskData[1].count = taskStatistic?.countIsDoneTasks != null
        ? taskStatistic?.countIsDoneTasks.toInt()
        : 0;
    taskData[2].count = taskStatistic?.countExpiredTasks != null
        ? taskStatistic?.countExpiredTasks.toInt()
        : 0;




    isLoading.changeBool(false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IsLoadingState>(
      create: (context) => isLoading,
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: defaultPadding * 3,
              ),
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          Head(isExecutor: isExecutor),
                          const TaskCards(),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          LastFiles(
                            tasks: tasks,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(top: defaultPadding),
                              child: const Statistic()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
