import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/pages/view_task/view_task_provider_data.dart';
import 'package:provider/provider.dart';
import '../../../models/task_response_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';

class Gallery extends StatelessWidget {
   const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Images?> images = WatchContext(context).watch<ViewTaskDate>().task!.images;
    return Container(
      padding:
      EdgeInsets.all(Responsive.isMobile(context) ? 0 : defaultPadding * 2),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            final url = images[index]!.url;
            return GestureDetector(
              child: ExtendedImage.network(
                url,
                cache: true,
              ),
              onTap: () {
                Modular.to.push(MaterialPageRoute(
                    builder: (context) => ImageCarousel(
                      images: images,
                      currentIndex: index,
                    )));
              },
            );
          }),
    );
  }
}


class ImageCarousel extends StatefulWidget {
  const ImageCarousel(
      {Key? key, required this.images, required this.currentIndex})
      : super(key: key);

  final List<Images?> images;
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
