import 'package:flutter/material.dart';

import '../../../models/task_category_response.dart';

class TaskData extends ChangeNotifier {
  String? _description;
  TaskCategory? _taskCategory;
  List<TaskCategory> _taskCategories = [];


  String? get description => _description;

  TaskCategory? get taskCategory => _taskCategory;

  List<TaskCategory> get taskCategories => _taskCategories;


  void changeDescription(String value) {
    _description = value;

    notifyListeners();
  }

  void changeCategory(TaskCategory value) {
    _taskCategory = value;
    notifyListeners();
  }

  void changeCategoryList(List<TaskCategory> value) {
    _taskCategories = value;
    notifyListeners();
  }
}
