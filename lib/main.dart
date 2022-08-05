import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pothole_front/generated/l10n.dart';
import 'package:flutter_pothole_front/pages/create_task/create_task_page.dart';
import 'package:flutter_pothole_front/pages/detection_edit/detetction_edit_page.dart';
import 'package:flutter_pothole_front/pages/detection_result/detection_result_page.dart';
import 'package:flutter_pothole_front/pages/home/home_page.dart';
import 'package:flutter_pothole_front/pages/info/info_page.dart';
import 'package:flutter_pothole_front/pages/login/login.dart';
import 'package:flutter_pothole_front/pages/map/map_page.dart';
import 'package:flutter_pothole_front/pages/task_list/task_list.dart';
import 'package:flutter_pothole_front/pages/view_task/view_task.dart';
import 'package:flutter_pothole_front/services/shared_service.dart';
import 'package:flutter_pothole_front/utils/theme.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');

    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: "",
        theme: theme,
        darkTheme: darkTheme,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [

    ChildRoute('/', child: (context, args) => const Info()),
    ChildRoute('/login', child: (context, args) => const Login()),


      //   ChildRoute('/', child: (context, args) => const HomePage(), children: [
      //     ChildRoute('/info',
      //         child: (context, args) => const Info(),
      //         guards: [AuthGuard()]),
      //     ChildRoute('/createTask',
      //         child: (context, args) => const CreateTask(),
      //         guards: [AuthGuard()]),
      //     ChildRoute('/detectionResult',
      //         child: (context, args) => const DetectionResult(),
      //         guards: [AuthGuard()]),
      //     ChildRoute('/taskList',
      //         child: (context, args) => const TaskListPage(),
      //         guards: [AuthGuard()]),
      //     ChildRoute('/map',
      //         child: (context, args) => const MapPage(),
      //         guards: [AuthGuard()]),
      //     ChildRoute('/detectionResult/:id',
      //         child: (context, args) => const DetectionEdit(),
      //         guards: [AuthGuard()]),
      //     ChildRoute('/viewTask/:id',
      //         child: (context, args) => const ViewTask(),
      //         // transition: TransitionType.size,
      //         guards: [AuthGuard()]),
      //   ], guards: [
      //     AuthGuard()
      //   ]),
      //   ChildRoute('/login', child: (context, args) => const Login()),
      ];
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return SharedService.isLoggedIn();
  }
}
