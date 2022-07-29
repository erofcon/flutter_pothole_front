import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/services/api_service.dart';
import 'package:latlong2/latlong.dart';

import '../../../generated/l10n.dart';
import '../../../models/related_user_model.dart';
import '../../../models/task_category_response.dart';
import '../../../utils/constants.dart';
import '../../../widgets/skeleton.dart';
import 'map_location.dart';

class SingleTaskPage extends StatefulWidget {
  const SingleTaskPage({Key? key}) : super(key: key);

  @override
  State<SingleTaskPage> createState() => _SingleTaskPageState();
}

class _SingleTaskPageState extends State<SingleTaskPage> {
  TaskCategory? taskCategory;
  RelatedUser? relatedUser;
  List<TaskCategory> taskCategories = [];
  List<RelatedUser> relatedUsers = [];
  late Future<void> _futureInitialize;
  LatLng? _latLng;
  PlatformFile? fileName;
  DateTime? dateTime;
  String? description;

  bool _isTaskSending = false;
  bool _categoryError = false;
  bool _executorError = false;
  bool _leadTimeError = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _futureInitialize = init();
  }

  Future<void> init() async {
    taskCategories = await APIService.getTaskCategory();
    relatedUsers = await APIService.getRelatedUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureInitialize,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  taskDescription(),
                  taskLocation(),
                  taskExecutor(),
                  Container(
                    margin: const EdgeInsets.all(defaultPadding),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_isTaskSending) {
                          _sendTask().then((value) {
                            if (value != null) {
                              if (value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Task created'),
                                  backgroundColor: Colors.green,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Error task created'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          });
                        }
                        return;
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                        elevation: MaterialStateProperty.all(10),
                      ),
                      child: _isTaskSending
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : const Icon(Icons.arrow_forward),
                    ),
                  ),
                ]));
          } else {
            return taskSkeleton();
          }
        });
  }

  Widget taskDescription() {
    return Card(
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Category and description of the task",
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: getCategory(),
            ),
            _categoryError
                ? const Text("error", style: TextStyle(color: Colors.red))
                : const Text(''),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextField(
                onChanged: (value) => description = value,
                decoration: const InputDecoration(
                  labelText: "Enter a description",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget taskLocation() {
    return Card(
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Select image and location",
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            const SizedBox(
              height: 40,
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MapLocation(
                        location: changeLocation,
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: Icon(Icons.location_on_outlined,
                    color: Theme.of(context).primaryColor),
                label: Text(
                  (() {
                    if (_latLng != null) {
                      return '${_latLng!.latitude} ${_latLng!.longitude}';
                    }
                    return 'Choose location';
                  })(),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            const SizedBox(
              height: 40,
            ),
            TextButton.icon(
                onPressed: _selectFile,
                icon: Icon(
                  Icons.image_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(fileName != null ? fileName!.name : "Select file",
                    style: TextStyle(color: Theme.of(context).primaryColor)))
          ],
        ),
      ),
    );
  }

  Widget taskExecutor() {
    return Card(
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Выберите срок выполения и исполнителя",
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            getRelatedUser(),
            _executorError
                ? const Text("error", style: TextStyle(color: Colors.red))
                : const Text(''),
            TextButton.icon(
                icon: Icon(
                  Icons.date_range,
                  color: Theme.of(context).primaryColor,
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(defaultPadding * 1.5))),
                onPressed: () {
                  _selectDate(context);
                },
                label: Text(
                  dateTime != null ? dateTime.toString() : "Select dateTime",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            _leadTimeError
                ? const Text("error", style: TextStyle(color: Colors.red))
                : const Text(''),
          ],
        ),
      ),
    );
  }

  Widget getCategory() {
    return DropdownButton<TaskCategory>(
      value: taskCategory,
      hint: Text(S.of(context).select_category_dropdown),
      onChanged: (TaskCategory? newValue) {
        setState(() {
          taskCategory = newValue!;
        });
      },
      items: taskCategories
          .map<DropdownMenuItem<TaskCategory>>((TaskCategory value) {
        return DropdownMenuItem<TaskCategory>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  Widget getRelatedUser() {
    return DropdownButton<RelatedUser>(
      value: relatedUser,
      hint: Text(S.of(context).select_related_user),
      onChanged: (RelatedUser? newValue) {
        setState(() {
          relatedUser = newValue!;
        });
      },
      items:
          relatedUsers.map<DropdownMenuItem<RelatedUser>>((RelatedUser value) {
        return DropdownMenuItem<RelatedUser>(
          value: value,
          child: Text('${value.firstName} ${value.lastName}'),
        );
      }).toList(),
    );
  }

  Widget taskSkeleton() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(defaultPadding),
            child: Container(
                padding: const EdgeInsets.all(defaultPadding * 2),
                child: const Skeleton(
                  height: 300,
                  width: double.infinity,
                  opacity: 0.05,
                )),
          ),
          Card(
            margin: const EdgeInsets.all(defaultPadding),
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 3),
              child: const Skeleton(
                height: 300,
                width: double.infinity,
                opacity: 0.05,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(defaultPadding),
            child: Container(
                padding: const EdgeInsets.all(defaultPadding * 3),
                child: const Skeleton(
                  height: 300,
                  width: double.infinity,
                  opacity: 0.05,
                )),
          ),
        ],
      ),
    );
  }

  void changeLocation(LatLng latLng) {
    setState(() {
      _latLng = latLng;
    });
  }

  void _selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    setState(() => fileName = result.files.first);
  }

  void _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3025));

    if (selected != null) {
      setState(() {
        dateTime = selected.toLocal();
      });
    }
  }

  Future<bool?> _sendTask() async {
    _hasError = false;
    _categoryError = false;
    _executorError = false;
    _leadTimeError = false;

    if (taskCategory == null) {
      _categoryError = true;
      _hasError = true;
    }
    if (relatedUser == null) {
      _executorError = true;
      _hasError = true;
    }
    if (dateTime == null) {
      _leadTimeError = true;
      _hasError = true;
    }

    if (_hasError) {
      setState(() {});
    } else {
      setState(() {
        _isTaskSending = true;
      });

      var v = await APIService.createSingleTask(
          taskCategory!.id, relatedUser!.id, dateTime!,
          description: description,
          file: fileName,
          latitude: _latLng?.latitude.toString(),
          longitude: _latLng?.longitude.toString());

      setState(() {
        _isTaskSending = false;
      });

      return v;
    }
    return null;
  }
}
