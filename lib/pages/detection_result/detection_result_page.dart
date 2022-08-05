import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/constants.dart';


class DetectionResult extends StatelessWidget {
  const DetectionResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Column(
       children: <Widget>[
         Card(
           margin: const EdgeInsets.all(defaultPadding),
           child:Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Container(
                   padding: const EdgeInsets.all(defaultPadding*2),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const <Widget>[
                       Text("Контрольный выезд на 21.03.2013"),
                       SizedBox(height: defaultPadding),
                       Text("колличество изображении 123")
                     ],
                   ),
                 ),
                 ElevatedButton.icon(onPressed: (){
                   Modular.to.navigate('/detectionResult/1');
                 }, icon: const Icon(Icons.delete), label: const Text("Открыть")),
                 const SizedBox(width: defaultPadding,),
                 ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.delete), label: const Text("Удалить")),
               ],
             ),
           ),
       ],

     );
  }
}


//
// class DetectionResult extends StatelessWidget {
//   const DetectionResult({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Card(
//         margin: const EdgeInsets.all(defaultPadding),
//         child: Container(
//           padding: const EdgeInsets.all(defaultPadding * 3),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text("Select video and datetime",
//                   style: Theme.of(context).textTheme.titleMedium),
//               const Divider(),
//               const SizedBox(
//                 height: 40,
//               ),
//               ElevatedButton(
//                   style: ButtonStyle(
//                       padding: MaterialStateProperty.all(
//                           const EdgeInsets.all(defaultPadding * 1.5))),
//                   onPressed: _selectFile,
//                   child: Text(name != null
//                       ? name!
//                       : "Select file")),
//               const SizedBox(
//                 height: 40,
//               ),
//               ElevatedButton(
//                   style: ButtonStyle(
//                       padding: MaterialStateProperty.all(
//                           const EdgeInsets.all(defaultPadding * 1.5))),
//                   onPressed: (){_selectDatetime(context);},
//                   child: Text(dateTime != null
//                       ? dateTime.toString()
//                       : "Select dateTime")),
//             ],
//           ),
//         ),
//       ),
//     );;
//   }
// }