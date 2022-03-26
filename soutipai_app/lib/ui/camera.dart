import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late File image;

  _pickanimagefromCam() async {
    File myImageCam = (await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
    )) as File;
    if (myImageCam != Null) {
      image = myImageCam;
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text("Only a simple example."),
        ),
        Container(
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          child: image == Null ? Text("There is no image!") : Image.file(image),
        ),
        FlatButton(
          onPressed: _pickanimagefromCam,
          child: Text("Cam"),
        ),
      ],
    );
  }
}