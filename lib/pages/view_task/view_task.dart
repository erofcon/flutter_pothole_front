
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/task_response_model.dart';
import 'package:flutter_pothole_front/pages/view_task/components/task_view_data.dart';
import 'package:flutter_pothole_front/pages/view_task/view_task_provider_data.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../services/api_service.dart';
import 'components/task_view_answer.dart';
import 'components/task_view_gallery.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  late Future<void> _futureInitialize;
  late ViewTaskDate task;

  @override
  void initState() {
    super.initState();
    _futureInitialize = init();
  }

  Future<void> init() async {
    TaskResponseModel ?result = await APIService.getDetailTask(Modular.args.params['id']);
    task = ViewTaskDate(result!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureInitialize,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<ViewTaskDate>(
            create: (_)=>task,
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Дорожная работа на 23.10.1996",
                    style: TextStyle(fontSize: 24),
                  ),
                  Gallery(),
                  TaskData(),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Divider(),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  TaskAnswer(),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 5,
          ));
        }
      },
    );
  }
}

