import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/info_task_card_data.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';


class TaskInfoCard extends StatelessWidget {
  const TaskInfoCard({Key? key, required this.info, required this.title})
      : super(key: key);
  final TaskCardInfo info;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Text("${title}".toUpperCase())),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Text("${info.count}")),
                  TextButton(
                    onPressed: () {
                      Modular.to.pushNamed('/viewTask/73');
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black12)),
                    child: Text(S.of(context).home_task_card_button),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: info.containerColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 218, 218, 218),
                  ),
                ],
              ),
              child: Icon(
                info.icon,
                color: info.iconColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class TaskInfoCard extends StatelessWidget {
//   const TaskInfoCard({Key? key, required this.info, required this.title}) : super(key: key);
//   final TaskCardInfo info;
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//
//     return Container(
//       padding: EdgeInsets.all(defaultPadding * 1.5),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromARGB(255, 218, 218, 218),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                     margin: EdgeInsets.only(left: defaultPadding * 0.5),
//                     child: Text("${title}".toUpperCase(),
//                         style: Theme.of(context).textTheme.caption)),
//                 Container(
//                   padding: EdgeInsets.only(left: defaultPadding * 0.5),
//                   child: Text("${info.count}"),
//                 ),
//                 TextButton(onPressed: () {}, child: Text(S.of(context).home_task_card_button)),
//               ],
//             ),
//           ),
//           if (_size.width > 445 || _size.width <=350)
//             Container(
//               decoration: BoxDecoration(
//                   color: info.containerColor,
//                   borderRadius: BorderRadius.circular(10)),
//               padding: EdgeInsets.all(_responseCount(_size.width)),
//               child: Icon(info.icon,
//                   color: info.iconColor, size: _size.width <= 1160 ? 20 : 24),
//             )
//         ],
//       ),
//     );
//   }
//
//   double _responseCount(double width) {
//     if (width >= 1260) {
//       return defaultPadding;
//     } else if (width < 1260 && width >= 1150) {
//       return defaultPadding * 0.6;
//     } else if (width < 1150 && width > 720) {
//       return defaultPadding;
//     } else if (width <= 720 && width >= 650) {
//       return defaultPadding * 0.3;
//     } else if (width < 650 && width >= 485) {
//       return defaultPadding;
//     } else if (width < 485) {
//       return defaultPadding * 0.4;
//     }
//
//     return defaultPadding;
//   }
// }
