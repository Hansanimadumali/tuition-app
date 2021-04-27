import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Messages",style: TextStyle(color: Colors.black,fontSize: 20.0),),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}