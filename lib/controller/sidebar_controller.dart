import 'package:flutter/material.dart';

class SideBarController extends ChangeNotifier {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  static GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  static void controlMenu() {
    if (SideBarController.scaffoldKey.currentState!.isDrawerOpen) {
      SideBarController.scaffoldKey.currentState!.openEndDrawer();
    } else {
      SideBarController.scaffoldKey.currentState!.openDrawer();
    }
  }

// toggleDrawer() async {
//   if (SideBarController.scaffoldKey.currentState!.isDrawerOpen) {
//     SideBarController.scaffoldKey.currentState!.openEndDrawer();
//   } else {
//     SideBarController.scaffoldKey.currentState!.openDrawer();
//   }
// }
}
