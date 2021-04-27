import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/student_attendance/student_attendance.dart';
import 'package:tution_app/pages/students/student_payment/student_payment.dart';
import 'package:tution_app/pages/students/student_profile/student_profile.dart';

class StudentPages extends StatefulWidget {
  final Student student;

  const StudentPages({Key key, this.student}) : super(key: key);

  @override
  State<StudentPages> createState() => new _StudentPagesState();
}

class _StudentPagesState extends State<StudentPages> {
  String _header = "profile";
  final PageController _controller = new PageController();


  @override
  void initState(){
    super.initState();
    _header = "profile";
  }

  _StudentPagesState(){
    _controller.addListener((){
      switch (_controller.page.toInt()){
        case 0:
          updateHeader("profile");
          break;
        case 1:
          updateHeader("attendance");
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(_header,style: TextStyle(color: Colors.black,fontSize: 20.0),),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: _addPages(),
    );
  }

  void updateHeader(String value) async{
    this.setState((){
      this._header = value;
    });
  }

  Widget _addPages() {
    return new PageView(
      children: <Widget>[
        Container(
          child: StudentProfile(student: widget.student,),
        ),
        Container(
          child: StudentAttendance(),
        ),
        Container(
          child: StudentPayment(),
        )
      ],
      controller: _controller,
    );
  }
}
