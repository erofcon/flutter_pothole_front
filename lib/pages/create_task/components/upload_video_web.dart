import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/pages/create_task/components/upload_video_data.dart';
import 'package:flutter_pothole_front/pages/create_task/components/upload_video_widget.dart';
import 'package:flutter_pothole_front/services/web_service.dart';
import 'package:large_file_uploader/large_file_uploader.dart';
import 'package:provider/provider.dart';

import '../../../utils/get_date_time.dart';

class RunDetection extends StatefulWidget {
  const RunDetection({Key? key}) : super(key: key);

  @override
  State<RunDetection> createState() => _RunDetectionState();
}

class _RunDetectionState extends State<RunDetection> {
  ChangeData changeData = ChangeData();

  final _largeFileUploader = LargeFileUploader();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeData>(
      create: (context) => changeData,
      child: RunDetectionPage(
        uploadCallback: upload,
        selectDateTimeCallback: selectDateTime,
        selectFileCallback: selectFile,
      ),
    );
  }

  void selectDateTime() async {
    final date = await selectDate(context);
    if (date == null) return;

    final time = await selectTime(context);

    if (time == null) return;

    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    changeData.changeDateTime(dateTime);
  }

  void selectFile() {
    _largeFileUploader.pick(
        type: FileTypes.video,
        callback: (file) {
          changeData.changeFile(file);
        });
  }

  void upload() async {
    if (changeData.file != null && changeData.dateTime != null) {
      changeData.changeLoading(true);

      runDetection(changeData.dateTime!, changeData.file, uploadProgress,
          uploadComplete, uploadFailure);
    }
  }

  void uploadProgress(progress) {
    changeData.changeProgress(progress);
  }

  void uploadComplete(response) {

    // var z = json.decode(response);
    print(response);
    changeData.changeLoading(false);
    changeData.changeProgress(0);

    changeData.changeFile(null);
    changeData.changeDateTime(null);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Created'),
      backgroundColor: Colors.green,
    ));
  }

  void uploadFailure() {
    changeData.changeLoading(false);
    changeData.changeProgress(0);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Error'),
      backgroundColor: Colors.red,
    ));
  }

  // Future<DateTime?> _selectDate(BuildContext context) async {
  //   final selected = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2025));
  //
  //   return selected;
  // }
  //
  // Future<TimeOfDay?> _selectTime(BuildContext context) async {
  //   final selected =
  //       await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //
  //   return selected;
  // }
}
