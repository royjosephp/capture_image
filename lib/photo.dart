import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class CapturePhoto extends StatefulWidget {
  @override
  _CapturePhotoState createState() => _CapturePhotoState();
}

class _CapturePhotoState extends State<CapturePhoto> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        child: Center(
          child: _image == null
              ? Column(children: [
                  Text("Take a photo of the offence"),
                  Icon(
                    Icons.photo_camera,
                    size: 50,
                  )
                ])
              : Image.file(_image),
        ),
        height: 250.0,
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
