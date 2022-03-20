import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final arguments;

  ResultPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ResultState();
  }
}

class ResultState extends State<ResultPage> {
  //模拟数据
  String _question="";
  List _listData = [
    {"id": 1, "questionName": "Question1", "questionAnswer": "Answer1"},
  ];
  int _selected = 0; //选择的题目
  bool _visible = false; //文本修改框是否可见
  double _minHeight = 200;

  var _questionText = TextEditingController();

  @override
  void initState(){
    super.initState();
    _question=widget.arguments["question"];
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
    Widget answerSection = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: const FractionalOffset(0.5, 0.7),
          children: [
            Column(
              children: [
                _buildContainer("题目"),
                _buildCard("questionName"),
              ],
            ),
            Positioned(
              top: 51,
              right: 3,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _visible ? _minHeight = 200 : _minHeight = 127;
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
                  _buildContainer("解析"),
                  _buildCard("questionAnswer"),
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
        ), //解析部分
      ],
    );

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
              () => Navigator.pushNamed(context, "/"), //TODO:此处为返回首页路由
              const CircleBorder()),
          _buildButtonColumn(
              const Image(
                image: AssetImage("assets/images/result/go_home.png"),
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),
              () => Navigator.pushNamed(context, "/photograph_page"),
              //TODO:此处为再拍一题路由
              const CircleBorder()),
        ],
      );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            _buildTextField(_question), //文本框
            answerSelector, //题目选择
            answerSection,
            buttonSection
            // _buildHttpField(_http)
          ],
        ),
      )
    );
  }

  //构建基础题目选择按钮
  Widget _buildButton(int index) {
    final num = index + 1;
    if (index < 5) {
      return MaterialButton(
        onPressed: () {
          setState(() {
            _selected = index;
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
  Card _buildCard(String string) {
    return Card(
      color: const Color(0xfff3c3c3),
      shadowColor: Colors.grey,
      elevation: 5,
      borderOnForeground: false,
      margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
      child: Container(
        constraints: BoxConstraints(minHeight: _minHeight),
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
    setState(() {
      _minHeight = 200;
      if (_visible) {
        _question = _questionText.text;
        _visible = !_visible;
      }
      _getData();
    });
  }

  //TODO: 获取数据，待实现
  Future _getData() async {
    print("begin");
    var uri =
        Uri.http("192.168.153.188:8080", "/getAnswer", {'question': _question});
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      print(result.body);
    } else {
      print(result.statusCode);
    }
    setState(() {
      _listData = json.decode(result.body);
    });
  }

  //TODO: 添加收藏，待实现
  Future _addCollection() async {}
}
