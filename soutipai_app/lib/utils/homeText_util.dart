// ignore_for_file: file_names
import 'dart:ui';
import 'package:flutter/cupertino.dart';

/*class Global{
  static num screenW; //设备的宽高
  static num screenH; //设备的宽高
  static num devicePixelRatio; // 设备的像素密度
  static Size physicalSize; // 设备的尺寸... (px)

  /// 初始化设备的宽高
  /// 全局记录设备的基本信息
  Global.initDeviceW_H() {
    // 从 window对象获取屏幕的物理尺寸(px) 及 像素密度
    final physicalSize = window.physicalSize;
    final devicePixelRatio = window.devicePixelRatio;
    Global.devicePixelRatio = devicePixelRatio;
    Global.physicalSize = physicalSize;
    // 计算出ios/android 常用的屏幕宽高 (dp / pt);
    Global.screenW =
        Global.physicalSize.width / Global.devicePixelRatio;
    Global.screenH =
        Global.physicalSize.height / Global.devicePixelRatio;
  }
}*/

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