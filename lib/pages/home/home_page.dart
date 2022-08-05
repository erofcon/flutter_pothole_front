import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/controller/sidebar_controller.dart';
import 'package:flutter_pothole_front/pages/home/components/sidebar.dart';
import 'package:flutter_pothole_front/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../models/login_response.dart';
import '../../services/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User? user;
  late Future<void> _futureInitialize;

  @override
  void initState() {
    super.initState();
    _futureInitialize = getUser();
  }

  Future<void> getUser() async {
    user = await SharedService.getUserDetails();
    if (user == null) {
      Modular.to.navigate('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureInitialize,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Provider<User>(
            create: (_) => user!,
            child: Scaffold(
              key: SideBarController.scaffoldKey,
              backgroundColor: Theme.of(context).backgroundColor,
              drawer: Responsive.isTablet(context) ? const SideBar() : null,
              appBar: AppBar(
                automaticallyImplyLeading:
                    Responsive.isTablet(context) ? true : false,
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
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
