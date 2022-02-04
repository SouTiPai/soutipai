import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ResultState();
  }
}

class ResultState extends State<ResultPage> {
  //模拟数据
  String _question = "在开发中，我们经常会用到输入框，那么在 flutter 中，如何获取当前输入框中的文本内容呢？";
  List _listData = [
    {"id": 1, "question": "Question1", "answer": "Answer1"},
    {"id": 2, "question": "Question2", "answer": "Answer2"},
    {"id": 3, "question": "Question3", "answer": "Answer3"},
    {"id": 4, "question": "Question4", "answer": "Answer4"},
    {"id": 5, "question": "Question5", "answer": "Answer5"},
    {"id": 6, "question": "Question6", "answer": "Answer6"},
  ];
  int _selected = 0; //选择的题目
  bool _visible = false; //文本修改框是否可见
  double _minHeight = 200;

  var _questionText = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //此处实现题目选择
    Widget answerSelector = new Container(
      padding: EdgeInsets.all(8.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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

    //此处实现题目解析
    Widget answerSection = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: const FractionalOffset(0.5, 0.7),
          children: [
            Container(
              child: Column(
                children: [
                  _buildContainer("题目"),
                  _buildCard("question"),
                ],
              ),
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
                child: Image(
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
              constraints: BoxConstraints(
                minHeight: 130,
              ),
              child: Column(
                children: [
                  _buildContainer("解析"),
                  _buildCard("answer"),
                ],
              ),
            ),
            Positioned(
              top: 40,
              right: 0,
              child: MaterialButton(
                onPressed: _addCollection,
                child: Image(
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
    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(
              Image(
                image: AssetImage("assets/images/result/photo_another.png"),
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),
              () => Navigator.pushNamed(context, "/"), //TODO:此处为返回首页路由
              CircleBorder()),
          _buildButtonColumn(
              Image(
                image: AssetImage("assets/images/result/go_home.png"),
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),
              () => Navigator.pushNamed(context, "/"), //TODO:此处为再拍一题路由
              CircleBorder()),
        ],
      ),
    );

    return Scaffold(
      body: Container(
          child: RefreshIndicator(
        onRefresh: _refresh,
        child: new ListView(
          children: [
            _buildTExtField(_question), //文本框
            answerSelector, //题目选择
            answerSection,
            buttonSection
          ],
        ),
      )),
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
        shape: CircleBorder(),
        minWidth: 30,
      );
    } else
      return Container(
        width: 0,
        height: 0,
      );
  }

  //构建底部跳转按钮
  Column _buildButtonColumn(Image image, Function function, ShapeBorder border) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new MaterialButton(
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
    return new Container(
        height: 70,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/result/text_background.png"),
                fit: BoxFit.fill)),
        child: Center(
          child: Text(
            "$string",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'LiShu',
              fontSize: 35,
            ),
          ),
        ));
  }

  //构建Card
  Card _buildCard(String string) {
    return new Card(
      color: Color(0xfff3c3c3),
      shadowColor: Colors.grey,
      elevation: 5,
      borderOnForeground: false,
      margin: EdgeInsets.fromLTRB(50, 5, 50, 5),
      child: Container(
        constraints: BoxConstraints(minHeight: _minHeight),
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Text(
          "${_listData[_selected][string]}",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  //构建文本框
  Widget _buildTExtField(String text) {
    _questionText = new TextEditingController(text: text);
    return SingleChildScrollView(
      child: Visibility(
        visible: _visible ? true : false,
        child: Container(
          margin: EdgeInsets.all(8.0),
          color: Color.fromARGB(255, 244, 244, 246),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "题目修改",
                style: TextStyle(
                  fontFamily: 'LiShu',
                  fontSize: 30,
                ),
              ),
              Card(
                color: Color(0xfff3c3c3),
                shadowColor: Colors.grey,
                elevation: 5,
                borderOnForeground: false,
                child: Container(
                  margin: EdgeInsets.all(15.0),
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

  //TODO: 下拉刷新，待实现
  Future _refresh() async {
    if (_visible) {
      setState(() {
        _minHeight = 200;
        _question = _questionText.text;
        _visible = !_visible;
        print("下拉刷新");
        //TODO:实现刷新
      });
    }
  }

  //TODO: 添加收藏，待实现
  Future _addCollection() async {}
}
