import 'package:flutter/material.dart';

class ColorsConst {
  static const Color black = Color(0XFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static final ButtonStyle buttonTheme = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.greenAccent[400]),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
        return RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        );
      }));
}
