import 'package:flutter/material.dart';

import '../utils/constants.dart';


class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width, required this.opacity})
      : super(key: key);

  final double? height, width;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity),
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    );
  }
}