import 'package:flutter/material.dart';
import 'package:soutipai_app/utils/homeText_util.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  final double leading = 0.5;
  final double fontSize = 45;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            // 图片作为底层
            Container(
              child: const Image(
                image: AssetImage("assets/images/land/land.jpg"),
                fit: BoxFit.cover,
              ),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            ),
            //Padding(
            //  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //),
          ],
        ));
  }
}
