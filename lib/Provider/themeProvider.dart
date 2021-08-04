import 'package:e_commerce/Consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      //scaffoldBackgroundColor: Colors.grey.shade900,
      // primaryColor: Colors.black87,

      brightness: Brightness.dark,
      buttonColor: ColorsConst.green600,
      colorScheme: ColorScheme.dark(),
      indicatorColor: ColorsConst.white,
      tabBarTheme: TabBarTheme(
          labelColor: ColorsConst.white,
          labelStyle: TextStyle(color: ColorsConst.white)),
      iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
      appBarTheme: AppBarTheme(
        elevation: 0,
        textTheme: TextTheme(
            title: TextStyle(
          color: ColorsConst.white,
          fontSize: 17,
        )),
        backgroundColor: ColorsConst.grey800,
        foregroundColor: ColorsConst.grey800,
      ));

  static final lightTheme = ThemeData(
    //scaffoldBackgroundColor: Colors.white,
    //primaryColor: Colors.white,

    brightness: Brightness.light,
    indicatorColor: ColorsConst.blue,
    tabBarTheme: TabBarTheme(
        labelColor: ColorsConst.black,
        labelStyle: TextStyle(color: ColorsConst.black)),
    colorScheme: ColorScheme.light(),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorsConst.black),
        elevation: 0,
        foregroundColor: ColorsConst.white,
        backgroundColor: ColorsConst.white,
        textTheme: TextTheme(
            title: TextStyle(
          color: ColorsConst.black,
          fontSize: 17,
        ))),

    buttonColor: ColorsConst.black,

    iconTheme: IconThemeData(color: ColorsConst.red, opacity: 0.8),
  );
}
