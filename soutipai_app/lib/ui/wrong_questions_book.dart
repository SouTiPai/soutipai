import 'package:flutter/material.dart';
import 'package:soutipai_app/utils/dio_utils.dart';

class WrongQuestionsBook extends StatefulWidget {
  const WrongQuestionsBook({Key? key}) : super(key: key);

  @override
  State<WrongQuestionsBook> createState() => WrongQuestionsBookState();
}

class WrongQuestionsBookState extends State<WrongQuestionsBook> {
  List _listData = [];

  final String _userId = "266b6dd4e58042b3a4b58ddf020d1e3f";

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _getData();
            }));
  }

  //每个按钮块要展示的信息，在这里传到outlinedButton的Text中
  //还需要数据库传数据来
  //在这里定义onPressed的action

  @override
  Widget build(BuildContext context) {
    List<Widget> questions = List.generate(
      _listData.length,
      (index) => OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/result_page",
              arguments: {"questionId": _listData[index]["questionId"]});
        },
        child: Card(
          color: const Color(0xfff3c3c3),
          shadowColor: Colors.grey,
          elevation: 5,
          borderOnForeground: false,
          margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: Container(
              constraints: BoxConstraints(minHeight: 190),
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    "题目 ${index + 1}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${_listData[index]["questionName"]}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
        ),
        //还需要考虑格式问题
        style: ButtonStyle(
            side: MaterialStateProperty.all(const BorderSide(
              color: Colors.blueGrey,
            )),
            minimumSize: MaterialStateProperty.all(const Size(100, 170)),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: Colors.black,
              fontFamily: "LiShu",
            ))),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white70,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Center(
          child: Column(
            children: <Widget>[
              //背景图片和三省亭的层叠布局
              Stack(alignment: Alignment.center, children: <Widget>[
                //图片
                Image.asset(
                    'assets/images/wrong_questions_book/SanXingTing_sus.jpg'),

                //三省亭，stack里用positioned绝对定位
                const Positioned(
                  left: 150,
                  bottom: 93,
                  child: Text(
                    '三省亭',
                    style: TextStyle(
                      fontFamily: "LiShu",
                      fontSize: 50,
                    ),
                  ),
                ),

                //返回按钮
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    iconSize: 40,
                  ),
                  left: 10,
                  top: 25,
                )
              ]),

              //错题按钮展示
              Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100.0),
                            topRight: Radius.circular(100.0)),
                        color: Colors.white,
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(40),
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          return questions[index];
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.white,
                          );
                        },
                      ))),
            ],
          ),
        )),
      ),
    );
  }

  //下拉刷新
  Future _refresh() async {
    _getData();
  }

  Future _getData() async {
    final res = await HttpUtils.instance
        .get("/collections/getAll", params: {"userId": _userId}, tips: true);
    _listData = res.data;
    setState(() {});
  }
}