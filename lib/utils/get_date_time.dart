

import 'package:flutter/material.dart';

Future<DateTime?> selectDate(BuildContext context) async {
  final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025));

  return selected;
}

Future<TimeOfDay?> selectTime(BuildContext context) async {
  final selected =
  await showTimePicker(context: context, initialTime: TimeOfDay.now());

  return selected;
}