import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/utils/constants.dart';

class DetectionEdit extends StatefulWidget {
  const DetectionEdit({Key? key}) : super(key: key);

  @override
  State<DetectionEdit> createState() => _DetectionEditState();
}

class _DetectionEditState extends State<DetectionEdit> {
  List<String> images = <String>[
    'https://photo.tuchong.com/14649482/f/601672690.jpg',
    'https://photo.tuchong.com/17325605/f/641585173.jpg',
    'https://photo.tuchong.com/3541468/f/256561232.jpg',
    'https://photo.tuchong.com/16709139/f/278778447.jpg',
    'https://photo.tuchong.com/15195571/f/233361383.jpg',
    'https://photo.tuchong.com/5040418/f/43305517.jpg',
    'https://photo.tuchong.com/3019649/f/302699092.jpg'
  ];

  List<int> selectIndex = [];
  bool _onLongPress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              final url = images[index];
              return GestureDetector(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                      decoration: BoxDecoration(
                          border: selectIndex.contains(index)
                              ? Border.all(color: Colors.lightBlue, width: 5)
                              : null),
                      child: ExtendedImage.network(url)),
                ),
                onLongPress: () {
                  setState(() {
                    selectIndex.add(index);
                    _onLongPress = true;
                  });
                },
                onTap: () {
                  if (_onLongPress) {
                    if (selectIndex.contains(index)) {
                      setState(() {
                        selectIndex.remove(index);
                      });
                      if (selectIndex.isEmpty) {
                        setState(() {
                          _onLongPress = false;
                        });
                      }
                    } else {
                      setState(() {
                        selectIndex.add(index);
                      });
                    }
                  } else {
                    Modular.to.push(MaterialPageRoute(
                        builder: (context) => ImageCarousel(
                              images: images,
                              imageRemove: _removeImage,
                              currentIndex: index,
                            )));
                  }
                },
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: ButtonTheme(
          minWidth: 0.0,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    _onLongPress = false;
                    selectIndex = [];
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    _onLongPress = false;
                    selectIndex = [];
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    _onLongPress = false;
                    selectIndex = [];
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.send_to_mobile_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel(
      {Key? key,
      required this.images,
      required this.imageRemove,
      required this.currentIndex})
      : super(key: key);

  final List<String> images;
  final Function(int index) imageRemove;
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
                String img = widget.images[index];
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Modular.to.pop();
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Theme.of(context).primaryColor,
                        )),
                    IconButton(
                        onPressed: () {
                          Modular.to.pop();
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        )),
                    IconButton(
                        onPressed: () {
                          Modular.to.pop();
                        },
                        icon: Icon(
                          Icons.send_to_mobile_outlined,
                          color: Theme.of(context).primaryColor,
                        )),
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
