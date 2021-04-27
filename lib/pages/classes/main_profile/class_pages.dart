import 'package:flutter/material.dart';
import 'package:tution_app/pages/classes/main_profile/class_dates.dart';
import 'package:tution_app/pages/classes/main_profile/class_payment.dart';
import 'package:tution_app/pages/classes/main_profile/class_profile.dart';

class ClassPages extends StatefulWidget {

  @override
  _ClassPagesState createState() => _ClassPagesState();
}

class _ClassPagesState extends State<ClassPages> {

  String _header = "profile";
  final PageController _controller = new PageController();

  @override
  void initState(){
    super.initState();
    _header = "profile";
  }


  _ClassPagesState(){
     _controller.addListener((){
      switch (_controller.page.toInt()){
        case 0:
          updateHeader("profile");
          break;
        case 1:
          updateHeader("class dates");
          break;
        case 2:
          updateHeader("payments");
          break;
        default:
          updateHeader("profile");

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(_header,style: TextStyle(color: Colors.black,fontSize: 20.0),),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: _addPages(),
      ),
    );
  }

  void updateHeader(String value) async{
    this.setState((){
      this._header = value;
    });
  }



  Widget _addPages(){
    return new PageView(
      children: <Widget>[
        Container(
          child: ClassProfile(),
        ),
        Container(
          child: ClassDates(),
        ),
        Container(
          child: ClassPayment(),
        )
      ],
      controller: _controller,
    );
  }
}