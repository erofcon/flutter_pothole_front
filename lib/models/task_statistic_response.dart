import 'dart:convert';


TaskStatistic taskStatistic(String str) =>
    TaskStatistic.fromJson(json.decode(str));

class TaskStatistic {
  TaskStatistic({
    required this.countCurrentTasks,
    required this.countIsDoneTasks,
    required this.countExpiredTasks,
  });

  late final int countCurrentTasks;
  late final int countIsDoneTasks;
  late final int countExpiredTasks;

  TaskStatistic.fromJson(Map<String, dynamic> json) {
    countCurrentTasks = json['count_current_tasks'];
    countIsDoneTasks = json['count_is_done_tasks'];
    countExpiredTasks = json['count_expired_tasks'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count_current_tasks'] = countCurrentTasks;
    data['count_new_tasks'] = countIsDoneTasks;
    data['count_expiring_tasks'] = countExpiredTasks;
    return data;
  }
}
