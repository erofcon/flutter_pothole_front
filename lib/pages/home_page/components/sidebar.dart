import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/models/login_response.dart';
import 'package:flutter_pothole_front/services/shared_service.dart';
import 'package:flutter_pothole_front/utils/constants.dart';

import '../../../controller/sidebar_controller.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/skeleton.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late bool isDark;
  late final User? user;
  late Future<void> _futureGetUser;

  @override
  void initState() {
    super.initState();
    _futureGetUser = getUser();

    AdaptiveTheme.of(context).mode.isLight == true
        ? isDark = false
        : isDark = true;
  }

  @override
  void dispose() {
    super.dispose();
    print("sid");
  }

  Future<void> getUser() async {
    user = await SharedService.getUserDetails();
    print(user!.username);
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 9.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: SafeArea(
        child: FutureBuilder(
          future: _futureGetUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 48,
                                height: 48,
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(48),
                                    // Image radius
                                    child: Image.asset(
                                      'assets/images/avatar.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.notifications_active_outlined,
                                  color: Theme.of(context).cardColor,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                                style: TextStyle(
                                    color: Theme.of(context).cardColor)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (AdaptiveTheme.of(context)
                                        .mode
                                        .isLight) {
                                      AdaptiveTheme.of(context).setDark();
                                      isDark = true;
                                    } else {
                                      AdaptiveTheme.of(context).setLight();
                                      isDark = false;
                                    }
                                  });
                                },
                                icon: isDark == true
                                    ? Icon(
                                        Icons.light_mode_outlined,
                                        color: Theme.of(context).cardColor,
                                      )
                                    : Icon(Icons.dark_mode_outlined,
                                        color: Theme.of(context).cardColor)),
                          ],
                        ),
                        Text((() {
                          if (user?.isSuperUser ?? true) {
                            return S.of(context).user_is_admin;
                          } else if (user?.isCreator ?? true) {
                            return S.of(context).user_is_curator;
                          } else if (user?.isExecutor ?? true) {
                            return S.of(context).user_is_executor;
                          }
                          return '';
                        })(), style: const TextStyle(color: Colors.white54)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        children: <Widget>[
                          DrawerList(
                              title: S.of(context).sidebar_list_info,
                              icon: Icons.info_outline,
                              press: () {
                                SideBarController.controlMenu();
                                Modular.to.navigate('/info_page');
                                // Modular.to.pushReplacementNamed('/info_page');
                              }),
                          if (user?.isSuperUser == true || user?.isCreator == true)
                          DrawerList(
                              title:
                                  S.of(context).sidebar_list_create_single_task,
                              icon: Icons.create_outlined,
                              press: () {
                                SideBarController.controlMenu();
                                Modular.to.navigate('/createTask');
                                // Modular.to.pushReplacementNamed('/createTask');
                              }),
                          if (user?.isSuperUser == true || user?.isCreator == true)
                          DrawerList(
                              title:
                                  S.of(context).sidebar_list_result_detection,
                              icon: Icons.reset_tv_outlined,
                              press: () {
                                SideBarController.controlMenu();
                                Modular.to.navigate('/detectionResult');
                                // Modular.to.pushReplacementNamed('/detectionResult');
                              }),
                          DrawerList(
                              title: S.of(context).sidebar_menu_map,
                              icon: Icons.map_outlined,
                              press: () {
                                SideBarController.controlMenu();
                                Modular.to.navigate('/map');
                                // Modular.to.pushReplacementNamed('/map');
                              }),
                          if (user?.isSuperUser == true || user?.isCreator == true)
                          DrawerList(
                              title: S.of(context).sidebar_menu_report,
                              icon: Icons.report_gmailerrorred_outlined,
                              press: () {}),
                          DrawerList(
                              title: S.of(context).sidebar_menu_log_out,
                              icon: Icons.logout,
                              press: () async {
                                await SharedService.logout();
                                SideBarController.controlMenu();
                                Modular.to.navigate('/login');
                                // Modular.to.pushReplacementNamed('/login');
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Skeleton(
                              height: 80,
                              width: 80,
                              opacity: 0.2,
                            ),
                            Skeleton(
                              height: 30,
                              width: 30,
                              opacity: 0.2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Skeleton(
                              height: 15,
                              width: 80,
                              opacity: 0.2,
                            ),
                            Skeleton(
                              height: 30,
                              width: 30,
                              opacity: 0.2,
                            ),
                          ],
                        ),
                        const Skeleton(
                          height: 15,
                          width: 80,
                          opacity: 0.2,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding, horizontal: defaultPadding),
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Skeleton(
                            height: 20,
                            width: double.infinity,
                            opacity: 0.2,
                          ),
                          Skeleton(
                            height: 20,
                            width: double.infinity,
                            opacity: 0.2,
                          ),
                          Skeleton(
                            height: 20,
                            width: double.infinity,
                            opacity: 0.2,
                          ),
                          Skeleton(
                            height: 20,
                            width: double.infinity,
                            opacity: 0.2,
                          ),
                          Skeleton(
                            height: 20,
                            width: double.infinity,
                            opacity: 0.2,
                          ),
                          Skeleton(
                            height: 20,
                            width: double.infinity,
                            opacity: 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<AdaptiveThemeMode?> getThemeMode() async {
    AdaptiveThemeMode? mode = await AdaptiveTheme.getThemeMode();
    return mode;
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      onTap: press,
      horizontalTitleGap: 1.0,
      leading: Icon(icon, color: Colors.black45),
      title: Text(
        title,
      ),
    );
  }
}
