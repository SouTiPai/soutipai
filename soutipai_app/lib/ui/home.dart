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
    return SafeArea(
        child: Stack(
      children: [
        // 图片作为底层
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 75,
                    ),
                    Container(
                      child: HomeTextWidget.textField(
                          "搜 题 派", 50.0, 1.0, FontWeight.w200, 43.0),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                    ),
                    Container(
                      height: 25,
                    ),
                    Container(
                      child: HomeTextWidget.textField("一 个 宁 静 而 平 凡 的 下 午 ：",
                          16.0, 2.5, FontWeight.w100, 1.0),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    ),
                    Container(
                      child: HomeTextWidget.textField(
                          "        我 们 的 故 事 从 这 片 池 塘 开 始 ... ...",
                          16.0,
                          2.5,
                          FontWeight.w100,
                          1.0),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: const Text(""),
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
        ),
        //
        //
        //
        Padding(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.35, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  highlightElevation: 0,
                  hoverColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  highlightColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  splashColor: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                        "错题",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'LiShu',
                        fontSize: 20,
                      ),
                    ),
                    //child: HomeTextWidget.textField("错题本", 20.0, 1.0, FontWeight.w100, 1.0),
                    //child: Text("错题本", style: TextStyle(fontFamily: "隶书"),),
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      //border: Border.all(color: const Color.fromRGBO(54, 52, 52, 1.0), width: 1),
                      color: const Color.fromRGBO(182, 161, 74, 0.6),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/wrong_questions_book_page')
              ),
              MaterialButton(
                  highlightElevation: 0,
                  hoverColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  highlightColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  splashColor: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "拍照",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'LiShu',
                        fontSize: 20,
                      ),
                    ),
                    //child: HomeTextWidget.textField("拍照", 20.0, 1.0, FontWeight.w100, 1.0),
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      //border: Border.all(color: const Color.fromRGBO(54, 52, 52, 1.0), width: 1),
                      color: const Color.fromRGBO(182, 161, 74, 0.6),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/photograph_page')
              ),
              MaterialButton(
                  highlightElevation: 0,
                  hoverColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  highlightColor: const Color.fromRGBO(0, 0, 0, 0.0),
                  splashColor: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "更多",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'LiShu',
                        fontSize: 20,
                      ),
                    ),
                    //child: HomeTextWidget.textField("更多", 20.0, 1.0, FontWeight.w100, 1.0),
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      ///border: Border.all(color: const Color.fromRGBO(54, 52, 52, 1.0), width: 1),
                      color: const Color.fromRGBO(182, 161, 74, 0.6),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/more_page')
              ),
            ],
          ),
        ),
        // 进入拍照
        // 进入错题本
        // 进入更多功能
      ],
    ));
  }
}
