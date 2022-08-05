import 'package:file_picker/file_picker.dart';

class SelectFile {
  void get select => selectFile();

  void selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
  }
}
