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
              _buildContainer("店", "非遗商店", Colors.blue),
              _buildContainer("我", "我的", Colors.green),
              _buildContainer("错", "错题本", Colors.blue),
            ],
          ),
        ),
      ),
    ));
  }

  Container _buildContainer(String str1, String str2, MaterialColor color) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ActionChip(
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(10),
        onPressed: () {},
        avatar: CircleAvatar(
          backgroundColor: color,
          child: Text(str1),
        ),
        label: Container(
            height: 100,
            width: 200,
            alignment: Alignment.center,
            child: Text(
              str2,
              style: TextStyle(
                fontSize: 45,
                fontFamily: "LiShu",
              ),
              textAlign: TextAlign.center,
            )),
        // Chip 形状
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
