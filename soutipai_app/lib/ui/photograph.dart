/*import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> getIdentifyCardDemo() async {
// Fetch the available cameras before initializing the app.
  try {
    cameras = await availableCameras();
    FlutterImageCompress.showNativeLog = true;
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  //return new IdentifyCard();
}

class IdentifyCard extends StatefulWidget {
  @override
  _IdentifyCardState createState() {
    return _IdentifyCardState();
  }
}

void logError(String code, String message) => print('Error: $code\nError Message: $message');

class _IdentifyCardState extends State<IdentifyCard> {
  CameraController controller;
  //String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  WidgetsBinding widgetsBinding;
  List<CameraDescription> cameras;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCameras();
    photoPath=null;
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: new Container(
          color: Colors.black,
          child: new Stack(children: <Widget>[
            new Column(
              children: <Widget>[
                Expanded(
                  flex: 6, //flex用来设置当前可用空间的占优比
                  child: new Stack(children: <Widget>[
                    _cameraPreviewWidget(), //相机视图
                    // _cameraFloatImage(),//悬浮的身份证框图
                  ]),
                ),
                Expanded(
                  //flex用来设置当前可用空间的占优比
                  flex: 1,
                  child: _takePictureLayout(), //拍照操作区域布局
                ),
              ],
            ),
            getPhotoPreview(), //图片预览布局
            Visibility(
              child: Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    photoPath = null;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
              visible: null != photoPath,
            ),
            Visibility(
              child: Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //返回图片
                    Navigator.pop(context, {"Img": photoPath});
                  },
                ),
              ),
              visible: null != photoPath,
            ),
          ]),
        ));
  }

  //相机
  Future<void> getCameras() async {
// Fetch the available cameras before initializing the app.
    try {
      cameras = await availableCameras();
      //FlutterImageCompress.showNativeLog = true;
      if (cameras != null && !cameras.isEmpty) {
        onNewCameraSelected(cameras[0]); // 后置摄像头
        // onNewCameraSelected(cameras[1]);// 前置摄像头
        if (mounted) {
          setState(() {});
        }
      }
    } on CameraException catch (e) {
      print(e.toString());
    }
  }

  Widget _takePictureLayout() {
    return new Align(
        alignment: Alignment.bottomCenter,
        child: new Container(
            color: Colors.blueAccent,
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4, //flex用来设置当前可用空间的占优比
                  child: new IconButton(
                    iconSize: 50.0,
                    onPressed: controller != null && controller.value.isInitialized && !controller.value.isRecordingVideo
                        ? onTakePictureButtonPressed
                        : null,
                    icon: Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                    flex: 3, //flex用来设置当前可用空间的占优比
                    child: IconButton(
                      icon: Text(
                        '返回',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                    )),
              ],
            )));
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context, null);
        },
      );
    } else {
      return new Container(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      );
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          videoController = null;
          videoController?.dispose();
        });
        if (filePath != null) {
          //showInSnackBar('Picture saved to $filePath');
          photoPath = filePath;
          setState(() {});
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  toRestartIdentify() {
    restart = true;
    photoPath = null;
    setState(() {});
    restart = false;
  }
}

class IdentifyCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showNextPage(context),
    );
  }

  showNextPage(BuildContext context) async {
    // await getIdentifyCardDemo(context);
  }
}

List<CameraDescription> cameras;
bool showProgressDialog = false;
bool restart = false;
var photoPath = null;

Future<File> getCompressImage(File file, String targetPath) async {
  var path = file.absolute.path;
  var result = await FlutterImageCompress.compressAndGetFile(
    path,
    targetPath,
    quality: 88,
    rotate: 180,
  );

  print(file.lengthSync());
  print(result.lengthSync());

  return result;
}

Future<String> getTempDir() async {
  var dir = await path_provider.getTemporaryDirectory();
  var targetPath = dir.absolute.path + "/temp.png";
  return targetPath;
}

Widget getPhotoPreview() {
  if (null != photoPath) {
    return new Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      alignment: Alignment.center,
      child: Image.file(File(photoPath)),
    );
  } else {
    return new Container(
      height: 1.0,
      width: 1.0,
      color: Colors.black,
      alignment: Alignment.bottomLeft,
    );
  }
}
*/



// ----------------------------------------------------------------

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
  var _imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(                                                            //返回home界面按钮
                  onPressed: () => Navigator.pushNamed(context, '/home_page'),
                  child: Image.asset(
                    'assets/images/photograph/goback.png',
                    width: 50,height: 50,
                  )
              ),
              // _ImageView(_imgPath),
              //
              //
              // ElevatedButton(
              //   onPressed: _takePhoto,
              //   child: Text("拍照"),
              // ),
              // ElevatedButton(
              //   onPressed: _openGallery,
              //   child: Text("选择照片"),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: Container(
            color: Colors.pink[50],
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(                                                            //调用相册按钮
                    onPressed: _openGallery,//() => Navigator.pushNamed(context, 'trypage'),
                    child: Image.asset(
                      'assets/images/photograph/photograph_storage_picture.png',
                      width: 50,height: 50,
                    )
                ),
                TextButton(                                                             //调用拍照按钮
                    onPressed:_takePhoto,
                    child: Image.asset(
                        'assets/images/photograph/photograph_picture.png',
                        width: 100,height: 100
                    )
                ),
                TextButton(                                                            //调用手电筒按钮
                    onPressed: _openGallery,//() => Navigator.pushNamed(context, 'trypage'),
                    child: Image.asset(
                      'assets/images/photograph/flashlight.png',
                      width: 50,height: 50,
                    )
                ),

              ],
            ),
          )
        ),
    );
  }

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return const Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }


  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
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