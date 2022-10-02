import 'package:flutter/material.dart';

class Mine extends StatefulWidget{
  const Mine({Key ? key}) : super(key: key);
  State<Mine> createState() => MineState();
}

  class MineState extends State<Mine>{
  @override
  Widget build(BuildContext context){
    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/mine/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children:<Widget>[
                      Image.asset(
                          'assets/images/mine/head.png',
                        width:200,
                        height:200,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "小玲",
                          style: TextStyle(
                            fontFamily: "LiShu",
                            fontSize: 65,
                          ),
                        ),
                      ),
                  ]

                  ),

                  _buildContainer("账户信息", Colors.blue, (){}),
                  _buildContainer( "注册/登陆", Colors.green, () {}),
                  _buildContainer( "修改密码", Colors.blue, () {}),
                  _buildContainer("退出登录", Colors.green, (){}),
                ],
              ),
            ),
          ),
        ));
  }

  Container _buildContainer(
       String str2, MaterialColor color, Function fun) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: ActionChip(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(10),
        onPressed: () => fun(),
        label: Container(
            height: 50,
            width: 250,
            alignment: Alignment.center,
            child: Text(
              str2,
              style: const TextStyle(
                fontSize: 40,
                fontFamily: "LiShu",
              ),
              textAlign: TextAlign.center,
            )),
        // Chip 形状
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  }
