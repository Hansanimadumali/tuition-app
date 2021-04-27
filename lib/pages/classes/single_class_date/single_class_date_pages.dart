import 'package:flutter/material.dart';
import 'package:tution_app/pages/classes/single_class_date/class_date_attendance.dart';
import 'package:tution_app/pages/classes/single_class_date/class_date_payment.dart';

class SingleClassDatePages extends StatefulWidget {
  @override
  _SingleClassDatePagesState createState() => _SingleClassDatePagesState();
}

class _SingleClassDatePagesState extends State<SingleClassDatePages> {

  final PageController _controller = new PageController();
  String _header = "attendance";

  @override
  void initState(){
    super.initState();
    _header = "attendance";
  }

  _SingleClassDatePagesState(){
         _controller.addListener((){
      switch (_controller.page.toInt()){
        case 0:
          updateHeader("attendance");
          break;
        case 1:
          updateHeader("payments");
          break;
        default:
          updateHeader("attendance");

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
          child: ClassDateAttendance(),
        ),
        Container(
          child: ClassDatePayment(),
        ),
      ],
      controller: _controller,
    );
  }
}