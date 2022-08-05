import 'package:flutter/material.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';
import 'package:flutter_pothole_front/pages/info/components/task_info_card.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:flutter_pothole_front/utils/responsive.dart';
import 'package:flutter_pothole_front/widgets/skeleton.dart';
import 'package:provider/provider.dart';

import '../../../utils/loading_provider.dart';

class TaskCards extends StatelessWidget {
  const TaskCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: FileInfoCardGridView(
        crossAxisCount: size.width < 650 ? 1 : 2,
        childAspectRatio: size.width < 650 ? 1.3 : 1,
      ),
      tablet: const FileInfoCardGridView(),
      desktop: FileInfoCardGridView(
        childAspectRatio: size.width < 1400 ? 1.1 : 2,
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: taskData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          if (Provider.of<IsLoadingState>(context).isLoading) {
            return const Skeleton(
              width: 200,
              height: 200,
              opacity: 0.05,
            );
          } else {
            if (index == 0) {
              return TaskInfoCard(
                info: taskData[0],
                title: S.of(context).home_task_card_1,
              );
            } else if (index == 1) {
              return TaskInfoCard(
                info: taskData[1],
                title: S.of(context).home_task_card_2,
              );
            } else {
              return TaskInfoCard(
                info: taskData[2],
                title: S.of(context).home_task_card_3,
              );
            }
          }
        });
  }
}
