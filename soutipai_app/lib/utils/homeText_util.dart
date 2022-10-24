// ignore_for_file: file_names
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class HomeTextWidget{
  static Widget textField(
      String text,
      var fontSize,
      var height,
      var fontWeight,
      var wordSpacing,
      ){
    return Text(
      text,
      style: TextStyle(
        fontFamily: "LiShu",
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
        color: const Color.fromRGBO(0, 0, 0, 1.0),
        wordSpacing: wordSpacing,
      ),
    );
  }
}