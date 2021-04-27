import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tution_app/services/nfc_service.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _nfcData = "no data";

  @override
  void initState(){
    super.initState();
    this.readNFC();
  }


  Future<void> startNFC() async{
    try{
      await NfcService.startNFC;
    }catch(e){
      print(e);
    }
  }

  Future<void> stopNFC() async{
    try{
      await NfcService.stopNFC;
    }catch(e){
      print(e);
    }
  }

  Future<void> readNFC() async {
    try{
      NfcService.read.listen((response) {
        setState(() {
          this._nfcData = response.toString();
        });
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_nfcData,style: TextStyle(fontSize: 25.0),),
        IconButton(
            icon: Icon(Icons.nfc),
            onPressed: startNFC
        ),
        IconButton(
            icon: Icon(Icons.close),
            onPressed: this.stopNFC
        )
      ],
    ),
    );
  }
}