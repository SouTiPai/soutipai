import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soutipai_app/utils/count_down_timer.dart';
import 'package:soutipai_app/utils/dio_utils.dart';
import 'package:soutipai_app/widgets/toast.dart';

class ResultPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final arguments;

  const ResultPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ResultState();
  }
}

class ResultState extends State<ResultPage> {
  bool _wrongBook = false;
  String _question = "";
  String _questionId = "";
  List _listData = [];
  int _selected = 0; //选择的题目
  bool _visible = false; //文本修改框是否可见
  bool _answerVisible = false; //答案是否可见
  double _minHeight = 190;
  String _userId = "266b6dd4e58042b3a4b58ddf020d1e3f";

  bool onLoading = true; //是否正在加载中

  var _questionText = TextEditingController();

  late CountdownController controller;

  late Timer t;

  @override
  void initState() {
    super.initState();
    controller = CountdownController(this, startCount: 5);
    if (widget.arguments["question"] != null) {
      _wrongBook = false;
      for (int i = 0; i < widget.arguments["question"].length; i++) {
        _question += widget.arguments["question"][i]["words"];
      }
    } else {
      _wrongBook = true;
      _questionId = widget.arguments["questionId"];
    }
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _getData();
              controller.start();
            }));
    t = Timer(const Duration(seconds: 0), () => {});
  }

  @override
  Widget build(BuildContext context) {
    //此处实现题目选择
    Widget answerSelector = Container();
    if (_listData.isNotEmpty) {
      answerSelector = Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Wrap(
            spacing: 0,
            runSpacing: 5.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List.generate(_listData.length, (index) {
              return _buildButton(index);
            }),
          ),
        ]),
      );
    }

    //此处实现题目解析
    Widget answerSection = Column();
    if (_listData.isNotEmpty) {
      answerSection = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: const FractionalOffset(0.5, 0.7),
            children: [
              Column(
                children: [
                  _buildContainer("题目"),
                  _buildCard("questionName", _minHeight),
                ],
              ),
              Positioned(
                top: 51,
                right: 3,
                child: MaterialButton(
                  onPressed: () {
                    if (_wrongBook == false)
                      setState(() {
                        _visible ? _minHeight = 190 : _minHeight = 117;
                        _visible = !_visible;
                      });
                  },
                  child: const Image(
                    image: AssetImage("assets/images/result/lamp.png"),
                    fit: BoxFit.cover,
                    height: 80,
                    width: 40,
                  ),
                  height: 80,
                  minWidth: 40,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              ),
            ],
          ), //题目部分
          Stack(
            alignment: const FractionalOffset(0.5, 0.7),
            children: [
              Container(
                constraints: const BoxConstraints(
                  minHeight: 130,
                ),
                child: Column(
                  children: [
                    _buildContainer("答案"),
                    _buildCard("questionAnswer", 20,
                        cardVisible: _answerVisible),
                  ],
                ),
              ),
            ],
          ), //答案部分
          Stack(
            alignment: const FractionalOffset(0.5, 0.7),
            children: [
              Container(
                constraints: const BoxConstraints(
                  minHeight: 130,
                ),
                child: Column(
                  children: [
                    _buildContainer("解析"),
                    _buildCard("questionRemark", _minHeight),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 0,
                child: MaterialButton(
                  onPressed: _addCollection,
                  child: const Image(
                    image: AssetImage("assets/images/result/cloud.png"),
                    fit: BoxFit.cover,
                    height: 40,
                    width: 70,
                  ),
                  height: 40,
                  minWidth: 70,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              ),
            ],
          ) //解析部分
        ],
      );
    } else {
      answerSection =
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          color: const Color(0xfff3c3c3),
          shadowColor: Colors.grey,
          elevation: 5,
          borderOnForeground: false,
          margin: const EdgeInsets.fromLTRB(50, 50, 50, 50),
          child: Container(
            constraints: const BoxConstraints(minHeight: 500),
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(
              onLoading ? "加载中..." : "您搜索的题目\n被外星人掳走了,\n请重试",
              style: const TextStyle(
                fontFamily: 'LiShu',
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ]);
    }

    //此处为底部图片按钮实现
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(
            const Image(
              image: AssetImage("assets/images/result/photo_another.png"),
              fit: BoxFit.cover,
              height: 70,
              width: 70,
            ),
            () => Navigator.popAndPushNamed(context, "/"),
            const CircleBorder()),
        _buildButtonColumn(
            const Image(
              image: AssetImage("assets/images/result/go_home.png"),
              fit: BoxFit.cover,
              height: 70,
              width: 70,
            ),
            () => Navigator.popAndPushNamed(context, "/photograph_page"),
            //TODO:此处为再拍一题路由
            const CircleBorder()),
      ],
    );

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: _refresh,
            child: SafeArea(
              child: ListView(
                children: [
                  _buildTextField(_question), //文本框
                  answerSelector, //题目选择
                  answerSection,
                  buttonSection
                  // _buildHttpField(_http)
                ],
              ),
            )));
  }

  //构建基础题目选择按钮
  Widget _buildButton(int index) {
    final num = index + 1;
    if (index < 5) {
      return MaterialButton(
        onPressed: () {
          setState(() {
            _selected = index;
            _answerVisible = false;
            controller = CountdownController(this, startCount: 5);
            controller.start();
            t.cancel();
            t = Timer(
                const Duration(milliseconds: 5000),
                    () => setState(() {
                  _answerVisible = true;
                }));
          });
        },
        child: Text(
          "$num",
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'LiShu',
            color: Colors.black,
          ),
        ),
        color: index == _selected ? Colors.red : Colors.white,
        splashColor: Colors.grey,
        shape: const CircleBorder(),
        minWidth: 30,
      );
    } else {
      // ignore: sized_box_for_whitespace
      return const Offstage();
    }
  }

  //构建底部跳转按钮
  Column _buildButtonColumn(
      Image image, Function function, ShapeBorder border) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            function();
          },
          child: image,
          shape: border,
        )
      ],
    );
  }

  //构建Container
  Container _buildContainer(String string) {
    return Container(
        height: 70,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/result/text_background.png"),
                fit: BoxFit.fill)),
        child: Center(
          child: Text(
            string,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'LiShu',
              fontSize: 35,
            ),
          ),
        ));
  }

  //构建Card
  Card _buildCard(String string, double height, {bool cardVisible = true}) {
    if (cardVisible) {
      return Card(
        color: const Color(0xfff3c3c3),
        shadowColor: Colors.grey,
        elevation: 5,
        borderOnForeground: false,
        margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
        child: Container(
          constraints: BoxConstraints(minHeight: height),
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Text(
            _listData.isEmpty ? "" : "${_listData[_selected][string]}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      );
    } else {
      return Card(
        color: const Color(0xfff3c3c3),
        shadowColor: Colors.grey,
        elevation: 5,
        borderOnForeground: false,
        margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
        child: Container(
          constraints: BoxConstraints(minHeight: height),
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: CountDownWidgetWrapper(
              builder: (count) {
                return Text('$count秒后显示答案');
              },
              controller: controller),
        ),
      );
    }
  }

  //构建文本框
  Widget _buildTextField(String text) {
    _questionText = TextEditingController(text: text);
    return SingleChildScrollView(
      child: Visibility(
        visible: _visible ? true : false,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          color: const Color.fromARGB(255, 244, 244, 246),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "题目修改",
                style: TextStyle(
                  fontFamily: 'LiShu',
                  fontSize: 30,
                ),
              ),
              Card(
                color: const Color(0xfff3c3c3),
                shadowColor: Colors.grey,
                elevation: 5,
                borderOnForeground: false,
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _questionText,
                    keyboardType: TextInputType.text,
                    maxLines: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //下拉刷新
  Future _refresh() async {
    _answerVisible = false;
    _minHeight = 190;
    if (_visible) {
      _question = _questionText.text;
      _visible = !_visible;
    }
    _getData();
  }

  Future _getData() async {
    setState(() {
      onLoading = true;
    });
    var res;
    if (_wrongBook == false)
      res = await HttpUtils.instance
          .get("/answers/get", params: {"question": _question}, tips: true);
    else
      res = await HttpUtils.instance.get("/answers/getById",
          params: {"questionId": _questionId}, tips: true);
    _listData = res.data;
    setState(() {
      controller = CountdownController(this, startCount: 5);
      controller.start();
      onLoading = false;
    });
    t.cancel();
    t = Timer(
        const Duration(milliseconds: 5000),
        () => setState(() {
              _answerVisible = true;
            }));
  }

  Future _addCollection() async {
    final res = await HttpUtils.instance
        .get("/collections/add", params: {"userId":_userId, "questionId": _listData[_selected]["id"]}, tips: true);
    setState(() {
      if (res.code == 200) {
        displayToast.show("收藏成功");
      } else if(res.code == 201){
        displayToast.show("取消收藏成功");
      } else {
        displayToast.show("收藏失败");
      }
    });
  }
}
