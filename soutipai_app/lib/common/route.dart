import 'package:flutter/material.dart';
import 'package:soutipai_app/ui/home.dart';
import 'package:soutipai_app/ui/result.dart';
import 'package:soutipai_app/ui/wrong_questions_book.dart';

final routes = {
  "/": (context) => MyHomePage(title: "搜题派"),
  "/result_page": (context) => ResultPage(),
  "/wrong_questions_book":(context)=>WrongQuestionsBook(),
};

var onGenerateRoute = (RouteSettings settings) {
  // 具体处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
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
