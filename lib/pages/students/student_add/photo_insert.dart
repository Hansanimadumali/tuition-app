import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoInsert extends StatelessWidget {
  final File profilePhoto;
  final Function onChange;

  const PhotoInsert({Key key, this.profilePhoto, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: new Container(
        height: 140.0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _makeProfilePhoto(),
            GestureDetector(
              onTap: _getImageFromCamera,
              child: new Container(
                margin: const EdgeInsets.only(top: 75.0, right: 80.0),
                height: 40.0,
                width: 40.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(20.0),
                  color: Color(0xff9fd3c7),
                ),
                child: new Icon(Icons.camera_alt, color: Color(0xff385170)),
              ),
            ),
            GestureDetector(
              onTap: _getImageFromGallery,
              child: new Container(
                margin: const EdgeInsets.only(top: 75.0, right: 170.0),
                height: 40.0,
                width: 40.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(20.0),
                  color: Color(0xff9fd3c7),
                ),
                child: new Icon(Icons.image, color: Color(0xff385170)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _makeProfilePhoto() {
    if (profilePhoto == null) {
      return new Container(
        height: 100.0,
        width: 100.0,
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(50.0),
            color: Colors.purple),
        child: new Icon(Icons.person, color: Colors.white, size: 70.0),
      );
    }

    return new Container(
        height: 100.0,
        width: 100.0,
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(50.0),
            color: Colors.purple),
        child: ClipOval(
          child: Image.file(
            profilePhoto,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
        ));
  }

  Future _getImageFromCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 3000.0, maxHeight: 300.0);

    onChange(image);
  }

  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 300.0, maxHeight: 300.0);
    onChange(image);
  }
}
