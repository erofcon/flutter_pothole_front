import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/pages/view_task/components/task_close.dart';
import 'package:flutter_pothole_front/pages/view_task/components/task_create_answer.dart';
import 'package:flutter_pothole_front/pages/view_task/components/test_data.dart';
import 'package:flutter_pothole_front/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../../models/login_response.dart';
import '../../../models/task_response_model.dart';
import '../../../utils/constants.dart';
import '../view_task_provider_data.dart';

class TaskAnswer extends StatefulWidget {
  const TaskAnswer({Key? key}) : super(key: key);

  @override
  State<TaskAnswer> createState() => _TaskAnswerState();
}

class _TaskAnswerState extends State<TaskAnswer> {
  int activeStepIndex = 0;

  late List<Answer> answers;

  late TestData test;

  late Future<void> _futureInitialize;

  @override
  void initState() {
    super.initState();
    _futureInitialize = asyncInit();
  }

  Future<void> asyncInit() async {
    answers = ReadContext(context).read<ViewTaskDate>().task!.answer;
    test = TestData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TestData>(
      create: (_) => test,
      child: FutureBuilder(
        future: _futureInitialize,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: !Responsive.isMobile(context)?const EdgeInsets.only(left: defaultPadding*2):EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: !Responsive.isMobile(context)?CrossAxisAlignment.start:CrossAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                      // padding: const EdgeInsets.only(bottom: defaultPadding*2),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: answers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      answers[index].replyDate,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(answers[index].description),
                                    if (answers[index].answerImages.isNotEmpty)
                                      GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 100,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10),
                                          itemCount:
                                              answers[index].answerImages.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            final url = answers[index]
                                                .answerImages[i]
                                                .url;
                                            return GestureDetector(
                                                onTap: () {
                                                  Modular.to.push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ImageCarousel(
                                                                images: answers[
                                                                        index]
                                                                    .answerImages,
                                                                currentIndex: i,
                                                              )));
                                                },
                                                child: ExtendedImage.network(url,
                                                    cache: true));
                                          })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  if (!ReadContext(context).read<User>().isSuperUser! && !ReadContext(context).read<ViewTaskDate>().isDone!)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: ElevatedButton(
                          onPressed: buttonCallback,
                          child: ReadContext(context).read<User>().isExecutor!
                              ? const Text("Добавить ответ")
                              : const Text("Закрыть задачу")),
                    ),

                  const SizedBox(height: defaultPadding,)
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void buttonCallback() {
    if (ReadContext(context).read<User>().isExecutor!) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return AddAnswer(
              uploadAnswer: updateAnswer,
            );
          });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CloseTask(
                closeTaskCallback: closeTaskCallback,
              ));
    }
  }

  void closeTaskCallback(bool value) {

    if(value){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Задача успешно закрыта!'),
        backgroundColor: Colors.green,
      ));
      ReadContext(context).read<ViewTaskDate>().addIsDone(true);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error'),
        backgroundColor: Colors.red,
      ));
    }


  }

  void updateAnswer(String value) {
    setState(() {
      answers.add(answerResponseModel(value));
    });
  }
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel(
      {Key? key, required this.images, required this.currentIndex})
      : super(key: key);

  final List<AnswerImages?> images;
  final int currentIndex;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ExtendedImageGesturePageView.builder(
              itemCount: widget.images.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              controller: ExtendedPageController(initialPage: currentIndex),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                String img = widget.images[index]!.url;
                Widget image = ExtendedImage.network(
                  img,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (ExtendedImageState state) {
                    return GestureConfig(
                      minScale: 1.005,
                      animationMinScale: 0.1,
                      maxScale: 4.0,
                      animationMaxScale: 4.5,
                      speed: 1.0,
                      initialScale: 1.005,
                      inPageView: true,
                      initialAlignment: InitialAlignment.center,
                      reverseMousePointerScrollDirection: true,
                    );
                  },
                );

                image = Container(
                  padding: const EdgeInsets.all(5.0),
                  child: image,
                );

                if (index == currentIndex) {
                  return Hero(tag: img + index.toString(), child: image);
                } else {
                  return image;
                }
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Modular.to.pop();
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).primaryColor,
                        )),
                    Text("34.121212 44.1221121212",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    Padding(
                        padding: const EdgeInsets.only(right: defaultPadding),
                        child: Text(
                            "${currentIndex + 1}/${widget.images.length.toString()}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




