import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/api_service.dart';
import '../../../utils/constants.dart';

class AddAnswer extends StatefulWidget {
  const AddAnswer({Key? key, required this.uploadAnswer}) : super(key: key);

  final Function(String) uploadAnswer;

  @override
  State<AddAnswer> createState() => _AddAnswerState();
}

class _AddAnswerState extends State<AddAnswer> {
  List<PlatformFile>? files;
  String? description;
  bool isSending = false;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    if (isSending) {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close))
              ],
            ),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    } else if (isDone) {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close))
              ],
            ),
            Center(
              child: Column(
                children: const <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size: 60,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: defaultPadding),
                    child: Text('Success upload'),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close))
              ],
            ),
            Description(onChanged: onChangeDescription),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            SelectImage(changeFileCallback: changeFileCallback),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            ElevatedButton(
                onPressed: sendAnswer, child: const Text("Добавить")),
          ],
        ),
      );
    }
  }

  void changeFileCallback(List<PlatformFile> files) {
    this.files = files;
  }

  void onChangeDescription(String value) {
    description = value;
  }

  void sendAnswer() async {
    setState(() {
      isSending = true;
    });

    Map<String, dynamic> result = await APIService.createAnswer(
        Modular.args.params['id'],
        description: description,
        files: files);

    if (result['completed']) {
      isDone = true;
    }

    widget.uploadAnswer(result['response']);

    setState(() {
      isSending = false;
    });
  }
}

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key, required this.changeFileCallback})
      : super(key: key);

  final Function(List<PlatformFile> file) changeFileCallback;

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  List<PlatformFile>? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: ElevatedButton(
          onPressed: _selectFile,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            primary: Colors.white,
            side: const BorderSide(width: 1, color: Colors.black12),
          ),
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 2),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.upload,
                  color: Colors.black,
                  size: 28,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  file != null
                      ? file!.first.name.toString()
                      : 'Выберите изображение',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          )),
    );
  }

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return;
    setState(() {
      file = result.files;
      widget.changeFileCallback(result.files);
    });
  }
}

class Description extends StatelessWidget {
  const Description({Key? key, required this.onChanged}) : super(key: key);
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          labelText: "Введите описание",
        ),
      ),
    );
  }
}