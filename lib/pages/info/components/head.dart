import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';
import 'package:flutter_pothole_front/utils/constants.dart';
import 'package:flutter_pothole_front/utils/responsive.dart';

class Head extends StatelessWidget {
  Head({Key? key, required this.isExecutor}) : super(key: key);

  bool isExecutor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            S.of(context).sidebar_list_info,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if(!isExecutor)
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                vertical:
                    defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
              ),
            ),
            onPressed: () {
              Modular.to.pushNamed('/createTask');
            },
            icon: const Icon(Icons.add),
            label: Text(S.of(context).button_add),
          ),
        ],
      ),
    );
  }
}
