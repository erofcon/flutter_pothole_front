import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/controller/sidebar_controller.dart';
import 'package:flutter_pothole_front/pages/home_page/components/sidebar.dart';
import 'package:flutter_pothole_front/utils/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SideBarController.scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Responsive.isTablet(context) ? const SideBar() : null,
      appBar: AppBar(
        automaticallyImplyLeading: Responsive.isTablet(context) ? true : false,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (Responsive.isDesktop(context)) const SideBar(),
            const Expanded(child: RouterOutlet())
          ],
        ),
      ),
    );
  }
}
