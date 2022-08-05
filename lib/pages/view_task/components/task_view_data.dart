
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task_response_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../view_task_provider_data.dart';
import 'task_view_map.dart';

class TaskData extends StatelessWidget {
  const TaskData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskResponseModel model = WatchContext(context).watch<ViewTaskDate>().task!;
    return Container(
      padding:
      EdgeInsets.all(Responsive.isMobile(context) ? 0 : defaultPadding * 2),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Card(
                        margin: const EdgeInsets.all(0),
                        color: Colors.yellow,
                        child: Padding(
                            padding: const EdgeInsets.all(defaultPadding * 0.5),
                            child: Text(model.category.name))),
                    Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        color: Colors.teal,
                        child: Padding(
                            padding: const EdgeInsets.all(defaultPadding * 0.5),
                            child: WatchContext(context).watch<ViewTaskDate>().isDone!?const Text("выполено"):Text(model.state))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: Text(model.description),
                ),
                const SizedBox(
                  height: defaultPadding * 0.5,
                ),
                Text("Срок выполнения: ${model.leadDateTime}"),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Исполнитель", style: TextStyle(fontSize: 19)),
                const SizedBox(
                  height: defaultPadding * 0.3,
                ),
                Text('${model.executor.firstName} ${model.executor.lastName}',
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(model.executor.numberPhone),
                Text(model.executor.email),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 500),
            child: const Map(),
          ),
        ],
      ),
    );
  }
}
