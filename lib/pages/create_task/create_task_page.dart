import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/pages/create_task/components/run_detection.dart';
import 'package:flutter_pothole_front/pages/create_task/components/single_task_page.dart';

import '../../models/login_response.dart';
import '../../services/shared_service.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    User? user = await SharedService.getUserDetails();

    if (user != null && user.isCreator != true) {
      Modular.to.navigate('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          TabBar(
            labelColor: Colors.blueAccent,
            labelStyle: TextStyle(fontSize: 18.0, fontFamily: 'Family Name'),
            unselectedLabelStyle:
                TextStyle(fontSize: 10.0, fontFamily: 'Family Name'),
            tabs: [
              Tab(text: "создать задачу"),
              Tab(text: "запустить обноружение"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleTaskPage(),
                RunDetection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
