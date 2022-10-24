import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => MoreState();
}

class MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "更多功能",
                  style: TextStyle(
                    fontFamily: "LiShu",
                    fontSize: 65,
                  ),
                ),
              ),
              _buildContainer("店", "非遗商店", Colors.blue, () {}),
              _buildContainer("我", "我的", Colors.green,
                      ()=> {
                        Navigator.pushNamed(
                            context, '/mine_page')
                      }),
              _buildContainer(
                  "错",
                  "错题本",
                  Colors.blue,
                  () => {
                        Navigator.pushNamed(
                            context, '/wrong_questions_book_page')
                      }),
            ],
          ),
        ),
      ),
    ));
  }

  Container _buildContainer(
      String str1, String str2, MaterialColor color, Function fun) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ActionChip(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(10),
        onPressed: () => fun(),
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
              style: const TextStyle(
                fontSize: 45,
                fontFamily: "LiShu",
              ),
              textAlign: TextAlign.center,
            )),
        // Chip 形状
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
