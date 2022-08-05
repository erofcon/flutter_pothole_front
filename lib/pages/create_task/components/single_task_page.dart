import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:latlong2/latlong.dart';

import '../../../generated/l10n.dart';
import '../../../models/related_user_model.dart';
import '../../../models/task_category_response.dart';
import '../../../services/api_service.dart';
import '../../../services/io_service.dart';
import '../../../utils/get_date_time.dart';
import 'map_location.dart';

class SingleTaskPage extends StatefulWidget {
  const SingleTaskPage({Key? key}) : super(key: key);

  @override
  State<SingleTaskPage> createState() => _SingleTaskPageState();
}

class _SingleTaskPageState extends State<SingleTaskPage> {
  int activeStepIndex = 0;
  String? description;
  TaskCategory? taskCategory;
  LatLng? location;
  RelatedUser? relatedUser;
  DateTime? expireDate;
  List<PlatformFile>? file = [];

  bool categoryError = false;
  bool executorError = false;
  bool expireDateError = false;

  bool uploadTask = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
            top: defaultPadding * 3, left: defaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Создание задачи",
              style: TextStyle(fontSize: 25),
            ),
            const Divider(),
            Stepper(
              type: StepperType.vertical,
              currentStep: activeStepIndex,
              steps: <Step>[
                Step(
                    state: categoryError ? StepState.error : StepState.indexed,
                    // state: activeStepIndex == 0
                    //     ? StepState.editing
                    //     : StepState.complete,
                    isActive: activeStepIndex == 0 ? true : false,
                    title: const Text("Категория и описание задачи"),
                    content: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Category(changeCategory: changeCategory),
                          categoryError
                              ? const Text(
                                  "пожалуйста, выберите категорию",
                                  style: TextStyle(color: Colors.red),
                                )
                              : const Text(''),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Description(
                            onChanged: changeDescription,
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        ],
                      ),
                    )),
                Step(
                    isActive: activeStepIndex == 1 ? true : false,
                    title: const Text("Изображение и локация"),
                    content: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: SelectImage(
                                changeFileCallback: changeFileCallback),
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: SetLocation(changeLocation: changeLocation),
                          ),
                        ],
                      ),
                    )),
                Step(
                    state: executorError == true || expireDateError == true
                        ? StepState.error
                        : StepState.indexed,
                    isActive: activeStepIndex == 2 ? true : false,
                    title: const Text("Исполнитель и срок выполнения"),
                    content: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RelUser(
                              changeRelatedUser: changeRelatedUser,
                            ),
                            executorError
                                ? const Text("пожалуйста, выберите исполнителя",
                                    style: TextStyle(color: Colors.red))
                                : const Text(''),
                            const SizedBox(
                              height: defaultPadding,
                            ),
                            Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: ExpireDate(
                                  changeExpireDate: changeExpireDate,
                                )),
                            expireDateError
                                ? const Text("пожалуйста, выберите исполнителя",
                                    style: TextStyle(color: Colors.red))
                                : const Text(''),
                          ]),
                    )),
              ],
              onStepTapped: (int index) {
                onStepContinue(next: index);
              },
              controlsBuilder: (context, details) {
                final isLastStep = activeStepIndex == 2;
                return Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: uploadTask
                        ? const Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 5.0,
                          ))
                        : Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: onStepContinue,
                                  child: isLastStep
                                      ? const Text('Отправить')
                                      : const Text('Вперед'),
                                ),
                              ),
                              const SizedBox(
                                width: defaultPadding,
                              ),
                              if (activeStepIndex > 0)
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: onStepCancel,
                                      child: const Text('Назад')),
                                ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onStepContinue({int? next}) async {
    if (activeStepIndex >= 0 && activeStepIndex < 2) {
      if (activeStepIndex == 0) {
        if (taskCategory == null) {
          categoryError = true;
        } else {
          categoryError = false;
        }
      }

      setState(() {
        next != null ? activeStepIndex = next : activeStepIndex += 1;
      });
    } else if (next != null) {
      if (relatedUser == null) {
        executorError = true;
      } else {
        executorError = false;
      }

      if (expireDate == null) {
        expireDateError = true;
      } else {
        expireDateError = false;
      }

      setState(() {
        activeStepIndex = next;
      });
    } else {



      if (relatedUser == null) {
        executorError = true;
      } else {
        executorError = false;
      }

      if (expireDate == null) {
        expireDateError = true;
      } else {
        expireDateError = false;
      }

      if (taskCategory != null && relatedUser != null && expireDate != null) {
        setState((){
          uploadTask = true;
        });
        bool result = await APIService.createSingleTask(
          taskCategory!.id,
          relatedUser!.id,
          expireDate!,
          description: description,
          files: file,
          latitude: location?.latitude.toString(),
          longitude: location?.latitudeInRad.toString(),
        );

        setState((){
          uploadTask = false;
        });

        if(result){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Задача успешно создана!'),
            backgroundColor: Colors.green,
          ));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Ошибка! Не удалось создать задачу'),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ошибка! Не все поля заполнены'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void onStepCancel() {
    if (activeStepIndex > 0 && activeStepIndex <= 2) {
      if (activeStepIndex == 2) {
        if (relatedUser == null) {
          executorError = true;
        } else {
          executorError = false;
        }

        if (expireDate == null) {
          expireDateError = true;
        } else {
          expireDateError = false;
        }
      }
      setState(() {
        activeStepIndex -= 1;
      });
    }
  }

  void changeDescription(String value) {
    description = value;
  }

  void changeCategory(TaskCategory category) {
    taskCategory = category;
  }

  void changeLocation(LatLng latLng) {
    location = latLng;
  }

  void changeRelatedUser(RelatedUser value) {
    relatedUser = value;
  }

  void changeExpireDate(DateTime value) {
    expireDate = value;
  }

  void changeFileCallback(List<PlatformFile> file) {
    this.file = file;
  }
}

class Category extends StatefulWidget {
  const Category({Key? key, required this.changeCategory}) : super(key: key);

  final Function(TaskCategory) changeCategory;

  @override
  State<Category> createState() => _TaskCategoryState();
}

class _TaskCategoryState extends State<Category> {
  List<TaskCategory> taskCategories = [];
  late Future<void> _futureInitialize;
  TaskCategory? taskCategory;

  @override
  void initState() {
    super.initState();
    _futureInitialize = init();
  }

  Future<void> init() async {
    taskCategories = await APIService.getTaskCategory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureInitialize,
        builder: (context, snapshot) {
          return DropdownButton<TaskCategory>(
            value: taskCategory,
            hint: Text(S.of(context).select_category_dropdown),
            onChanged: (TaskCategory? newValue) {
              setState(() {
                taskCategory = newValue!;
                widget.changeCategory(newValue);
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
          labelText: "Введите описание задачи",
        ),
      ),
    );
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
    return ElevatedButton(
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
                size: 48,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(
                file != null ? file!.first.name.toString() : 'Выберите изображение',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ));
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

class SetLocation extends StatefulWidget {
  const SetLocation({Key? key, required this.changeLocation}) : super(key: key);
  final Function(LatLng latLng) changeLocation;

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MapLocation(
                location: changeLocation,
              ),
              // fullscreenDialog: true,
            ),
          );
        },
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
                Icons.location_on_outlined,
                color: Colors.black,
                size: 48,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(
                latLng != null
                    ? '${latLng!.latitude}  ${latLng!.longitude}'
                    : 'Select Location',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ));
  }

  void changeLocation(LatLng latLng) {
    setState(() {
      this.latLng = latLng;
      widget.changeLocation(latLng);
    });
  }
}

class RelUser extends StatefulWidget {
  const RelUser({Key? key, required this.changeRelatedUser}) : super(key: key);

  final Function(RelatedUser) changeRelatedUser;

  @override
  State<RelUser> createState() => _RelUser();
}

class _RelUser extends State<RelUser> {
  RelatedUser? relatedUser;
  List<RelatedUser> relatedUsers = [];
  late Future<void> _futureInitialize;

  @override
  initState() {
    super.initState();
    _futureInitialize = init();
  }

  Future<void> init() async {
    relatedUsers = await APIService.getRelatedUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureInitialize,
      builder: (context, snapshot) => DropdownButton<RelatedUser>(
        value: relatedUser,
        hint: Text(S.of(context).select_related_user),
        onChanged: (RelatedUser? newValue) {
          setState(() {
            relatedUser = newValue!;
            widget.changeRelatedUser(newValue);
          });
        },
        items: relatedUsers
            .map<DropdownMenuItem<RelatedUser>>((RelatedUser value) {
          return DropdownMenuItem<RelatedUser>(
            value: value,
            child: Text('${value.firstName} ${value.lastName}'),
          );
        }).toList(),
      ),
    );
  }
}

class ExpireDate extends StatefulWidget {
  const ExpireDate({Key? key, required this.changeExpireDate})
      : super(key: key);

  final Function(DateTime dateTime) changeExpireDate;

  @override
  State<ExpireDate> createState() => _ExpireDateState();
}

class _ExpireDateState extends State<ExpireDate> {
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _selectDate(context);
        },
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
                Icons.date_range_outlined,
                color: Colors.black,
                size: 48,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(
                dateTime != null ? dateTime.toString() : "Выбрать дату",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ));
  }

  void _selectDate(BuildContext context) async {
    final selected = await selectDate(context);

    if (selected != null) {
      setState(() {
        dateTime = selected;
        widget.changeExpireDate(selected);
      });
    }
  }
}

