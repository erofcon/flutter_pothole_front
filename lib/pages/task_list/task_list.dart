import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/task_list_response_model.dart';
import 'package:flutter_pothole_front/services/api_service.dart';
import 'package:flutter_pothole_front/utils/responsive.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListState();
}

class _TaskListState extends State<TaskListPage> {
  // final List<Map> _products = List.generate(30, (i) {
  //   return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  // });

  late Future<void> _futureInitialize;

  late TaskList? taskList;

  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _futureInitialize = asyncInit();
  }

  Future<void> asyncInit() async {
    String? response = await APIService.getTaskList();
    taskList = taskResult(response!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureInitialize,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 15,
                // horizontalMargin: 0.1,
                // sortColumnIndex: _currentSortColumn,
                // sortAscending: _isAscending,
                headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
                columns: [
                  const DataColumn(label: Text('Дата')),
                  const DataColumn(label: Text('Состояние')),
                  const DataColumn(label: Text('Исполнитель')),
                  if(!Responsive.isMobile(context))
                    const DataColumn(label: Text('Куратор')),
                ],
                rows: taskList!.results.map((item) {
                  return DataRow(
                    onSelectChanged: (_){
                      Modular.to.navigate('/viewTask/${item.id}');
                    },
                    cells: [
                      DataCell(Text(item.createDateTime)),
                      DataCell(Text(item.state)),
                      DataCell(Text('${item.executor.firstName} ${item.executor.lastName}')),
                      if(!Responsive.isMobile(context))
                      DataCell(Text('${item.creator.firstName} ${item.creator.lastName}')),
                    ]
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// DataColumn(
//     label: const Text(
//       'Price',
//       style: TextStyle(
//           color: Colors.blue, fontWeight: FontWeight.bold),
//     ),
//     // Sorting function
//     onSort: (columnIndex, _) {
//       setState(() {
//         _currentSortColumn = columnIndex;
//         if (_isAscending == true) {
//           _isAscending = false;
//           // sort the product list in Ascending, order by Price
//           _products.sort((productA, productB) =>
//               productB['price'].compareTo(productA['price']));
//         } else {
//           _isAscending = true;
//           // sort the product list in Descending, order by Price
//           _products.sort((productA, productB) =>
//               productA['price'].compareTo(productB['price']));
//         }
//       });
//     }),