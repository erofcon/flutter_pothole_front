import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:large_file_uploader/large_file_uploader.dart';
import 'dart:html' as html;
import '../../../services/api_service.dart';
import '../../../utils/constants.dart';

class RunDetection extends StatefulWidget {
  const RunDetection({Key? key}) : super(key: key);

  @override
  State<RunDetection> createState() => _RunDetectionState();
}

class _RunDetectionState extends State<RunDetection> {
  DateTime? dateTime;
  PlatformFile? fileName;
  bool _isFileUploading = false;
  final _largeFileUploader = LargeFileUploader();
  html.File? file;

  Future<DateTime?> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));

    return selected;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final selected =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    return selected;
  }

  void _selectDatetime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(defaultPadding * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Select video and datetime",
                    style: Theme.of(context).textTheme.titleMedium),
                const Divider(),
                const SizedBox(
                  height: 40,
                ),
                TextButton.icon(
                    icon: Icon(Icons.file_copy_outlined,
                        color: Theme.of(context).primaryColor),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(defaultPadding * 1.5))),
                    onPressed: _selectFile,
                    label: Text(
                        fileName != null ? fileName!.name : "Select file",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor))),
                const SizedBox(
                  height: 40,
                ),
                TextButton.icon(
                    icon: Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColor,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(defaultPadding * 1.5))),
                    onPressed: () {
                      _selectDatetime(context);
                    },
                    label: Text(
                      dateTime != null
                          ? dateTime.toString()
                          : "Select dateTime",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                if (!_isFileUploading) {
                  _runDetection();
                }
                // if (!_isTaskSending) {
                //   _sendTask().then((value) {
                //     if (value != null) {
                //       if (value) {
                //         ScaffoldMessenger.of(context)
                //             .showSnackBar(const SnackBar(
                //           content: Text('Task created'),
                //           backgroundColor: Colors.green,
                //         ));
                //       } else {
                //         ScaffoldMessenger.of(context)
                //             .showSnackBar(const SnackBar(
                //           content: Text('Error task created'),
                //           backgroundColor: Colors.red,
                //         ));
                //       }
                //     }
                //   });
                // }
                // return;
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                elevation: MaterialStateProperty.all(10),
              ),
              child: _isFileUploading
                  ? const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : const Icon(Icons.arrow_forward),
              // child: _isTaskSending
              //     ? const SizedBox(
              //     height: 15,
              //     width: 15,
              //     child: CircularProgressIndicator(
              //       color: Colors.white,
              //     ))
              //     : const Icon(Icons.arrow_forward),
            ),
          ),
        ]),
      ),
    );
  }

  void _selectFile() async {
    // ImagePicker image  = await ImagePicker().pickVideo(source: ImageSource.gallery);
    _largeFileUploader.pick(
      type: FileTypes.video,
      callback: (file){
        this.file = file;
      }
    );






    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(type: FileType.video);
    // if (result == null) return;
    //
    // setState(() => fileName = result.files.first);
  }

  Future<bool?> _runDetection() async {
    setState(() {
      _isFileUploading = true;
    });

    // var v = await APIService.runDetection(dateTime!, fileName);
    var v = await APIService.runDetection(dateTime!, file, _largeFileUploader);
    setState(() {
      _isFileUploading = false;
    });

    return v;
  }
}

// Future<bool?> _sendTask() async {
//
//     var v = await APIService.runDetection(dateTime!, fileName, upload);
//
// }

void upload(double k) {
  print(k);
}
