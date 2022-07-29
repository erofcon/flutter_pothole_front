import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';
import 'package:flutter_pothole_front/pages/info_page/components/task_info_card.dart';
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

// double _getAspectRation(double width) {
//   if (width > 1400) {
//     return 2;
//   } else if (width < 1400 && width >= 1150) {
//     return 1.5;
//   } else if (width < 1150 && width > 840) {
//     return 2;
//   } else if (width < 840 && width >= 700) {
//     return 1.5;
//   } else if (width < 700 && width >= 650) {
//     return 1.4;
//   } else if (width < 650 && width >= 530) {
//     return 1.8;
//   } else if (width < 530 && width >= 390) {
//     return 1.2;
//   } else if (width < 390 && width > 350) {
//     return 1;
//   }
//
//   return 2;
// }

// class TaskCards extends StatefulWidget {
//   const TaskCards({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<TaskCards> createState() => _TaskCardsState();
// }
//
// class _TaskCardsState extends State<TaskCards> {
//   late Future<void> _futureInitialize;
//   bool isLoading = true;
//   TaskStatistic? taskStatistic;
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   void init() async {
//     taskStatistic = await APIService.getTaskStatistic();
//
//     taskData[0].count = taskStatistic?.countCurrentTasks!=null?taskStatistic?.countCurrentTasks.toInt():0;
//     taskData[1].count = taskStatistic?.countIsDoneTasks!=null?taskStatistic?.countIsDoneTasks.toInt():0;
//     taskData[2].count = taskStatistic?.countExpiredTasks!=null?taskStatistic?.countExpiredTasks.toInt():0;
//
//     setState((){
//       isLoading = false;
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Responsive(
//       mobile: FileInfoCardGridView(
//         isLoading: isLoading,
//         crossAxisCount: size.width < 650 ? 1 : 2,
//         childAspectRatio: size.width < 650 ? 1.3 : 1,
//       ),
//       tablet: FileInfoCardGridView(isLoading: isLoading),
//       desktop: FileInfoCardGridView(
//         isLoading: isLoading,
//         childAspectRatio: size.width < 1400 ? 1.1 : 2,
//       ),
//     );
//   }
// }
//
// double _getAspectRation(double width) {
//   if (width > 1400) {
//     return 2;
//   } else if (width < 1400 && width >= 1150) {
//     return 1.5;
//   } else if (width < 1150 && width > 840) {
//     return 2;
//   } else if (width < 840 && width >= 700) {
//     return 1.5;
//   } else if (width < 700 && width >= 650) {
//     return 1.4;
//   } else if (width < 650 && width >= 530) {
//     return 1.8;
//   } else if (width < 530 && width >= 390) {
//     return 1.2;
//   } else if (width < 390 && width > 350) {
//     return 1;
//   }
//
//   return 2;
// }
//
// class FileInfoCardGridView extends StatelessWidget {
//   const FileInfoCardGridView({
//     Key? key,
//     this.crossAxisCount = 3,
//     this.childAspectRatio = 1,
//     required this.isLoading,
//   }) : super(key: key);
//
//   final int crossAxisCount;
//   final double childAspectRatio;
//   final bool isLoading;
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: taskData.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           crossAxisSpacing: defaultPadding,
//           mainAxisSpacing: defaultPadding,
//           childAspectRatio: childAspectRatio,
//         ),
//         itemBuilder: (context, index) {
//           if (isLoading) {
//             return const Skeleton(
//               width: 200,
//               height: 200,
//               opacity: 0.05,
//             );
//           } else {
//             if (index == 0) {
//               return TaskInfoCard(
//                 info: taskData[0],
//                 title: S.of(context).home_task_card_1,
//               );
//             } else if (index == 1) {
//               return TaskInfoCard(
//                 info: taskData[1],
//                 title: S.of(context).home_task_card_2,
//               );
//             } else {
//               return TaskInfoCard(
//                 info: taskData[2],
//                 title: S.of(context).home_task_card_3,
//               );
//             }
//           }
//         });
//   }
// }
