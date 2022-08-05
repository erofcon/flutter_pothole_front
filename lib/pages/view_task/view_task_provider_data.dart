import 'package:flutter/material.dart';

import '../../models/task_response_model.dart';

class ViewTaskDate with ChangeNotifier {
  late TaskResponseModel _task;
  bool _isDone = false;

  ViewTaskDate(this._task):_isDone=_task.isDone;

  TaskResponseModel? get task => _task;
  bool? get isDone => _isDone;

  void changeTask(TaskResponseModel task) {
    _task = task;
    notifyListeners();
  }

  void addIsDone(bool value) {
    _isDone = value;
    notifyListeners();
  }
}
