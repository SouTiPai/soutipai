import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_camera_pugin/flutter_custom_camera_pugin.dart';

class TestPage extends StatefulWidget{
  const testPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Row(

    )
  }
  Column _buildButtonColumn(Image image, Function function, ShapeBorder border) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            function();
          },
          child: image,
          shape: border,
        )
      ],
    );
  }
}

///代码清单 2-1
///打开相机
void openCamera() async {
  CameraConfigOptions options = new CameraConfigOptions();

  ///默认自定义相册是否显示 相册切换
  options.isShowSelectCamera = true;

  ///默认自定义相册是否显示 前后镜头切换
  options.isShowPhotoAlbum = true;

  ///默认自定义相册是否显示 闪光灯开关按钮
  options.isShowFlashButtonCamera = true;

  ///调起自定义相机
  ///拍照的返回结果
  CameraResultInfo resultInfo =
  await FlutterCustomCameraPugin.openCamera(cameraConfigOptions: options);

  if (resultInfo.code == 200) {
    imageFile = new File(resultInfo.data["lImageUrl"]);
  }else if (resultInfo.code == 201) {
    ///201 是拍照取消 如点击了关闭按钮
    ///或者是 Android 手机的后退按钮
  }
  setState(() {});
}

/// 相册配置使用参数
class CameraConfigOptions {

  ///0.0.1 版本
  ///默认自定义相册是否显示 相册切换
  bool isShowPhotoAlbum = true;

  ///默认自定义相册是否显示 前后镜头切换
  bool isShowSelectCamera = true;

  ///默认自定义相册是否显示 闪光灯开关按钮
  bool isShowFlashButtonCamera = true;

}

class CameraResultInfo {
  ///消息标识
  int code;
  ///回调的消息
  String message ='';
  ///回调的数据
  dynamic data ;
  ///回调的方法名
  String method ='';
}

///打开相册
void openPhotoAlbum() async {
  /// 相册的选择返回结果
  /// 选择成功与取消都会回调
  CameraResultInfo resultInfo =await FlutterCustomCameraPugin.openPhotoAlbum();
  if (resultInfo.code == 200) {
    imageFile = new File(resultInfo.data["lImageUrl"]);
  }
}