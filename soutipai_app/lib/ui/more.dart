import 'package:flutter/material.dart';

class more extends StatefulWidget {
  const more({Key? key}) : super(key: key);

  @override
  State<more> createState() => _moreState();
}

class _moreState extends State<more> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "更多功能",
              style: TextStyle(
                //fontFamily:
                fontSize: 30,
              ),
            ),
            ActionChip(
              onPressed: () {},
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("错"),
              ),
              label: Text("错题本"), // 文本 Widget
              labelStyle:
              TextStyle(color: Colors.red, fontSize: 30), // 文本样式，TextStyle
              labelPadding: EdgeInsets.fromLTRB(15, 50, 0, 50), // 文本外边距 Padding

              // Chip 形状
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
            ),
            ActionChip(
              onPressed: () {},
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("视"),
              ),
              label: Text("视频讲解"), // 文本 Widget
              labelStyle:
              TextStyle(color: Colors.red, fontSize: 30), // 文本样式，TextStyle
              labelPadding: EdgeInsets.fromLTRB(15, 50, 0, 50), // 文本外边距 Padding

              // Chip 形状
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
            ),
            ActionChip(
              onPressed: () {},
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("错"),
              ),
              label: Text("ActionChip"), // 文本 Widget
              labelStyle:
              TextStyle(color: Colors.red, fontSize: 30), // 文本样式，TextStyle
              labelPadding: EdgeInsets.fromLTRB(15, 50, 0, 50), // 文本外边距 Padding

              // Chip 形状
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
