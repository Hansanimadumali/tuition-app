import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:tution_app/models/student.dart';
import 'package:url_launcher/url_launcher.dart';


String createNameInitials(Student student) {
  return student.firstName.toUpperCase()[0] + student.lastName.toUpperCase()[0];
}

void makeCall (String number) async{
  String url = "tel:"+number;
  if(await canLaunch(url)){
    await launch(url);
  } else{
    throw 'Could not launch $url';
  }
}


void sendMessage (String number) async{
  String url = "sms:"+number;
  if(await canLaunch(url)){
    await launch(url);
  } else{
    throw 'Could not launch $url';
  }
}

Future<Image> compressImageFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 300,
    minHeight: 300,
    quality: 94,
  );
  Image image = Image.memory(Uint8List.fromList(result));
  return image;
}

