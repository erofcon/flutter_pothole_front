import 'dart:html' as html;

import 'package:large_file_uploader/large_file_uploader.dart';


class SelectFile{

  final largeFileUploader = LargeFileUploader();
  html.File? thumbnail;

  void get select => selectFile();

  void selectFile() async {
    largeFileUploader.pick(
        type: FileTypes.video,
        callback: (file) {
          thumbnail = file;
        });
  }
}

