import 'package:flutter/material.dart';
import 'package:soutipai_app/utils/homeText_util.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final double leading = 0.5;
  final double fontSize = 45;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Column(
                children: [
                  Container(
                    height: 145,
                  ),
                  /*Transform.translate(
                      offset: Offset(0, -fontSize * leading / 2),
                    child: Text(
                      "搜题派",
                      strutStyle: StrutStyle(
                          forceStrutHeight: true,
                        height: 1,
                        leading: leading,
                      ),
                      style: TextStyle(
                        fontFamily: "LiShu",
                        fontSize: fontSize,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                      ),
                    ),
                  ),*/
                  Container(
                    child: HomeTextWidget.textField("搜 题 派",
                        40.0, 1.0, FontWeight.w200, 43.0),
                    /*child: Text(
                      "搜 题 派",
                      //textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: "LiShu",
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        wordSpacing: 43,
                      ),
                    ),*/
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                  ),
                  Container(height: 25,),
                  Container(
                    child: HomeTextWidget.textField("一 个 宁 静 而 平 凡 的 下 午 ：",
                        16.0, 2.5, FontWeight.w100, 1.0),
                    /*child: Text(
                      "一 个 宁 静 而 平 凡 的 下 午 ：",
                      style: TextStyle(
                        fontFamily: "LiShu",
                        fontSize: 16,
                        height: 2.5,
                        fontWeight: FontWeight.w100,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        wordSpacing: 1,
                      ),
                    ),*/
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(40, 0 , 0, 0),
                  ),
                  Container(
                    child: HomeTextWidget.textField("        我 们 的 故 事 从 这 片 池 塘 开 始 ... ...",
                        16.0, 2.5, FontWeight.w100, 1.0),
                    /*child: Text(
                      "        我 们 的 故 事 从 这 片 池 塘 开 始 ... ...",
                      style: TextStyle(
                        fontFamily: "LiShu",
                        fontSize: 16,
                        height: 2.5,
                        fontWeight: FontWeight.w100,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        wordSpacing: 1,
                      ),
                    ),*/
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(40, 0 , 0, 0),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const Text(
                      ""
                    ),
                  ),
                ],
              ),
          ),
          Container(
            child: const Image(
              image: AssetImage("assets/images/home/flowers.png"),
              fit: BoxFit.cover,
            ),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
        ],
      ),
      color: const Color.fromRGBO(214, 213, 213, 1),
    );
  }
}
