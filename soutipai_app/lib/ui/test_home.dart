import 'package:flutter/material.dart';

class TestHome extends StatelessWidget {
  var stack = Stack(
    alignment: const FractionalOffset(0.5, 0.7),
    children: const <Widget>[
      CircleAvatar(
        backgroundImage: NetworkImage(
            "https://avatars2.githubusercontent.com/u/41252899?s=460&v=4"),
        radius: 100.0,
      ),
      Positioned(
        top: 10.0,
        left: 10.0,
        child: Text("YFC"),
      ),
      Positioned(
        bottom: 10.0,
        right: 10.0,
        child: Text("https://ayang818.github.io/"),
      )
    ],
  ); //使用变量创建重叠的组件，起到减轻代码量的效果
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "stack层叠布局",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("stack 层叠布局"),
          backgroundColor: Colors.pink,
        ),
        body: Center(child: stack),
      ),
    );
  }
}
