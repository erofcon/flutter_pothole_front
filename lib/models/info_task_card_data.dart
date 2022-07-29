import 'package:flutter/material.dart';

class TaskCardInfo {
  int? count;
  String? title;
  final IconData? icon;
  final Color? iconColor;
  final Color? containerColor;

  TaskCardInfo({
    this.title,
    this.count,
    this.icon,
    this.iconColor,
    this.containerColor,
  });
}

List taskData = [
  TaskCardInfo(
    title: null,
    count: 0,
    icon: Icons.warning_amber_rounded,
    iconColor: Colors.orange,
    containerColor: Colors.yellow[100],
  ),
  TaskCardInfo(
      title: null,
      count: 0,
      icon: Icons.check,
      iconColor: Colors.green,
      containerColor: Colors.green[100]
  ),
  TaskCardInfo(
    title: null,
    count: 0,
    icon: Icons.error_outline_rounded,
    iconColor: Colors.red,
    containerColor: Colors.red[100]
  ),
];
