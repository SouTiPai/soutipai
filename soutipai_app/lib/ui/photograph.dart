import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                //返回home界面按钮
                onPressed: () => Navigator.pushNamed(context, '/'),
                child: Image.asset(
                  'assets/images/photograph/goback.png',
                  width: 50,
                  height: 50,
                )),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
          child: Container(
        color: Colors.pink[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
                //调用相册按钮
                onPressed: _openGallery,
                //() => Navigator.pushNamed(context, 'trypage'),
                child: Image.asset(
                  'assets/images/photograph/photograph_storage_picture.png',
                  width: 50,
                  height: 50,
                )),
            TextButton(
                //调用拍照按钮
                onPressed: _takePhoto,
                child: Image.asset(
                    'assets/images/photograph/photograph_picture.png',
                    width: 100,
                    height: 100)),
            TextButton(
                //调用手电筒按钮
                onPressed: _openGallery,
                //() => Navigator.pushNamed(context, 'trypage'),
                child: Image.asset(
                  'assets/images/photograph/flashlight.png',
                  width: 50,
                  height: 50,
                )),
          ],
        ),
      )),
    ));
  }

  /*图片控件*/
  /*Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return const Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }*/

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.popAndPushNamed(context, "/crop_picture_page",
          arguments: {"image": image});
    }
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.popAndPushNamed(context, "/crop_picture_page",
          arguments: {"image": image});
    }
  }
}

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
/*

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
*/
