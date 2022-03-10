import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';



/*class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: screenDemo (),
    );
  }
}
*/
class ScreenDemo extends StatefulWidget {
  const ScreenDemo({Key? key}) : super(key: key);

  @override
  _ScreenDemoState createState() => _ScreenDemoState();
}

class _ScreenDemoState extends State<ScreenDemo> {

  final GlobalKey<ExtendedImageEditorState> _editorKey =      //定义key，以方便操作ExtendedImageEditorState
  GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedImage.asset(                              //要编辑的照片
        'assets/images/screenshot/5.jpg',
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,                       //图片模式：编辑
        extendedImageEditorKey: _editorKey,                   //用于裁剪旋转翻转
        initEditorConfigHandler: (state) {                    //编辑器配置的回调(图片加载完成时)
          return EditorConfig(
            maxScale: 8.0,                                    //最大的缩放倍数
            cropRectPadding: const EdgeInsets.all(10.0),      //裁剪框跟图片layout区域之间的距离。
            hitTestSize: 30.0,                                //裁剪框四角以及边线能够拖拽的区域的大小
            cropAspectRatio: null,                            //裁剪框的宽高比
            cornerColor: Colors.pink[50],                     //裁剪框四角图形的颜色
            cornerSize: const Size(30.0, 5.0),                //裁剪框四角图形的大小
            lineColor: Colors.pink[200],                      //裁剪框线的颜色
            lineHeight: 1.3,                                  //裁剪框线的粗细
          );
        },
      ),

      bottomNavigationBar: SingleChildScrollView(
        child: Container(
              color: Colors.pink[50],
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(                                                            //返回拍照界面按钮
                      onPressed: () => Navigator.pushNamed(context, 'trypage'),
                      child: Image.asset(
                        'assets/images/screenshot/2.png',
                        width: 50,height: 50,
                      )
                  ),
                  TextButton(
                      onPressed:(){



                      },
                      child: Image.asset(
                          'assets/images/screenshot/3.png',
                          width: 100,height: 100
                      )
                  ),
                  TextButton(                                                           //图片顺时针旋转90°按钮
                    onPressed: () => _editorKey.currentState?.rotate(),
                    child: Image.asset(
                        'assets/images/screenshot/4.png',
                        width: 50,height: 50
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}

class TryPage extends StatelessWidget {
  const TryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.settings)
        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child:  Column(
          children: [
            ElevatedButton(onPressed:() => Navigator.pop(context),
                child: Text('返回')
            )
          ],
        ),
      ),
    );
  }
}

