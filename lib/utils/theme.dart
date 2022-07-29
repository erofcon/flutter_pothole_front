import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith();

final lightTheme = ThemeData.light().copyWith(
  drawerTheme: const DrawerThemeData(
    elevation: 0.0,
  ),
  backgroundColor: const Color.fromRGBO(243, 243, 249, 1),
  cardColor: Colors.white,
  primaryColorLight:  const Color.fromRGBO(64, 81, 137, 1),
  primaryColor: const Color.fromRGBO(64, 81, 137, 1),
  primaryIconTheme: IconThemeData(color: Colors.lightBlue[200]),
  appBarTheme: const AppBarTheme(color: Color.fromRGBO(64, 81, 137, 1)),
);

final lightDrawerTheme = ThemeData(textTheme: TextTheme(headline1: TextStyle(color: Colors.white)));
