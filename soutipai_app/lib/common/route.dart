import 'package:flutter/material.dart';
import 'package:soutipai_app/ui/crop_picture.dart';
import 'package:soutipai_app/ui/home.dart';
import 'package:soutipai_app/ui/more.dart';
import 'package:soutipai_app/ui/photograph.dart';
import 'package:soutipai_app/ui/result.dart';
import 'package:soutipai_app/ui/wrong_questions_book.dart';

final routes = {
  "/": (context) => const MyHomePage(title: "搜题派"),
  "/result_page": (context,{arguments}) => ResultPage(arguments: arguments),
  "/wrong_questions_book_page": (context) => const WrongQuestionsBook(),
  "/more_page": (context) => const more(),
  "/crop_picture_page": (context,{arguments}) => ScreenDemo(arguments:arguments),
  "/photograph_page": (context) => const ImagePickerWidget(),
  "/home_page": (context) => const MyHomePage(title: "搜题派"),
  "/camera_page": (context) => const MyHomePage(title: "搜题派"),

};

// ignore: prefer_function_declarations_over_variables
var onGenerateRoute = (RouteSettings settings) {
  // 具体处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  // ignore: unnecessary_null_comparison
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
