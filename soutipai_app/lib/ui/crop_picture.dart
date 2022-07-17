// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as prefix;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soutipai_app/utils/dio_utils.dart';

class ScreenDemo extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final arguments;

  const ScreenDemo({Key? key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenDemoState();
  }
}

class _ScreenDemoState extends State<ScreenDemo> {
  final GlobalKey<ExtendedImageEditorState>
      _editorKey = //定义key，以方便操作ExtendedImageEditorState

      GlobalKey<ExtendedImageEditorState>();
  late XFile image;

  @override
  void initState() {
    super.initState();
    image = widget.arguments["image"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.file(File(image.path)),
        /*ExtendedImage.asset(                              //要编辑的照片
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
      ),*/

        bottomNavigationBar: SingleChildScrollView(
            child: Container(
          color: Colors.pink[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                  //返回拍照界面按钮
                  onPressed: () =>
                      Navigator.pushNamed(context, '/photograph_page'),
                  child: Image.asset(
                    'assets/images/screenshot/2.png',
                    width: 50,
                    height: 50,
                  )),
              TextButton(
                  onPressed: () async {
                    prefix.MultipartFile img =
                        await prefix.MultipartFile.fromFile(
                      image.path, //图片路径
                          filename: "data/admin/" + //TODO:更改文件名(admin为用户id)
                          DateTime.now().millisecondsSinceEpoch.toString() +
                          ".jpg", //图片名称
                    );
                    final res = await HttpUtils.instance
                        .upload("/ocr", params: {"file": img}, tips: true);
                    Navigator.popAndPushNamed(context, "/result_page",
                        arguments: {"question": res.JSON["words_result"]});
                  },
                  child: Image.asset('assets/images/screenshot/3.png',
                      width: 100, height: 100)),
              TextButton(
                //图片顺时针旋转90°按钮
                onPressed: () => _editorKey.currentState?.rotate(),
                child: Image.asset('assets/images/screenshot/4.png',
                    width: 50, height: 50),
              ),
            ],
          ),
        )));
  }
}

class TryPage extends StatelessWidget {
  const TryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试'),
        leading: const Icon(Icons.menu),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [const Icon(Icons.settings)],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('返回'))
            ],
          ),
        ),
      ),
    );
  }
}
