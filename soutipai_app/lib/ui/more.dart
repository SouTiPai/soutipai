import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class more extends StatefulWidget {
  const more({Key? key}) : super(key: key);

  @override
  State<more> createState() => _moreState();
}

class _moreState extends State<more> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/more/shouhuigufengbeijingtupian-32913140_1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(10),
                child: Text(
                  "更多功能",
                  style: TextStyle(
                    fontFamily: "LiShu",
                    fontSize: 65,
                  ),
                ),
              ),
              Container(
                color: Color.fromRGBO(0, 0, 0, 0),
                margin: EdgeInsets.all(10),
                child: ActionChip(
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                  onPressed: () {},
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("店"),
                  ),
                  label: Text("非遗商店"),
                  // 文本 Widget
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontFamily: "LiShu",
                  ),
                  // 文本样式，TextStyle
                  labelPadding: EdgeInsets.fromLTRB(20, 48, 27, 50),
                  // 文本外边距 Padding
                  // Chip 形状
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ActionChip(
                  backgroundColor: Colors.white,
                  //padding: EdgeInsets.fromLTRB(30, 30, 10, 5),
                  onPressed: () {},
                  avatar: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text("错"),
                  ),
                  label: Text("错题本"),
                  // 文本 Widget
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontFamily: "LiShu",
                  ),
                  // 文本样式，TextStyle
                  labelPadding: EdgeInsets.fromLTRB(23, 50, 65, 50),
                  // 文本外边距 Padding

                  // Chip 形状
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ActionChip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  onPressed: () {},
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("我"),
                  ),
                  label: Text("我的   "),
                  // 文本 Widget
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontFamily: "LiShu",
                  ),
                  // 文本样式，TextStyle
                  labelPadding: EdgeInsets.fromLTRB(45, 45, 60, 40),
                  // 文本外边距 Padding

                  // Chip 形状
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
