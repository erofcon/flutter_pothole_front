import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/api_service.dart';

class CloseTask extends StatefulWidget {
  const CloseTask({Key? key, required this.closeTaskCallback})
      : super(key: key);
  final Function(bool) closeTaskCallback;

  @override
  State<CloseTask> createState() => _CloseTaskState();
}

class _CloseTaskState extends State<CloseTask>  {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: closeTask,
            child: const Text('OK'),
          ),
        ],
      );
    }
  }

  Future<void> closeTask() async {
    setState((){
      isLoading = true;
    });
    bool result = await APIService.closeTask(Modular.args.params['id']);
    widget.closeTaskCallback(result);
    Navigator.pop(context, 'OK');
  }
}