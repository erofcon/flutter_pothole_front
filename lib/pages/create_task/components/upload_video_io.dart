import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/pages/create_task/components/upload_video_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pothole_front/services/io_service.dart';
import '../../../utils/get_date_time.dart';
import 'upload_video_data.dart';

class RunDetection extends StatefulWidget {
  const RunDetection({Key? key}) : super(key: key);

  @override
  State<RunDetection> createState() => _RunDetectionState();
}

class _RunDetectionState extends State<RunDetection> {
  ChangeData changeData = ChangeData();

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
  //
  // void _selectDatetime(BuildContext context) async {
  //   final date = await _selectDate(context);
  //   if (date == null) return;
  //
  //   final time = await _selectTime(context);
  //
  //   if (time == null) return;
  //   setState(() {
  //     dateTime = DateTime(
  //       date.year,
  //       date.month,
  //       date.day,
  //       time.hour,
  //       time.minute,
  //     );
  //   });
  // }

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

  void selectFile() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      changeData.changeFile(result.files.first);
    }
  }

  void upload() {
    if (changeData.file != null && changeData.dateTime != null) {
      changeData.changeLoading(true);

      runDetection(changeData.dateTime!, changeData.file, uploadProgress,
          uploadComplete, uploadFailure);
    }
  }


  void uploadProgress(send, total) {
    changeData.changeProgress((send / total * 100).toInt());
  }

  void uploadComplete() {
    changeData.changeLoading(false);
    changeData.changeProgress(0);

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


}
