import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';
import 'package:flutter_pothole_front/models/task_grid.dart';
import 'package:flutter_pothole_front/utils/constants.dart';

class LastFiles extends StatelessWidget {
  const LastFiles({Key? key, required this.tasks}) : super(key: key);

  final List<TaskGrid> tasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).home_last_file_grid_title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              height: 325,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text(S.of(context).task_grid_data),
                  ),
                  DataColumn(
                    label: Text(S.of(context).task_grid_category),
                  ),
                  DataColumn(
                    label: Text(S.of(context).task_grid_description),
                  ),
                  DataColumn(
                    label: Text(S.of(context).task_grid_state),
                  ),
                ],
                rows: List.generate(
                  tasks.length,
                  (index) => recentFileDataRow(tasks[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(TaskGrid task) {
  return DataRow(
    cells: [
      DataCell(Text('${task.data}')),
      DataCell(Text('${task.category}')),
      DataCell(Text('${task.description}')),
      DataCell(Text('${task.state}')),
    ],
  );
}
