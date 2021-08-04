import 'dart:ui';
import 'package:e_commerce/Consts/colors.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonColor: isDarkTheme ? ColorsConst.green600 : Colors.blue,
        indicatorColor: isDarkTheme ? Colors.white : Colors.black,
        tabBarTheme: TabBarTheme(
            labelColor: isDarkTheme ? Colors.white : Colors.black,
            labelStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
            )),
        appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
              title: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 17,
          )),
          backgroundColor: isDarkTheme ? Colors.grey[800] : Colors.white,
          foregroundColor: isDarkTheme ? Colors.grey[800] : Colors.white,
        ));
  }
}
