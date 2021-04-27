import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/student_profile/card_add.dart';
import 'package:tution_app/pages/students/student_profile/class_list_box.dart';
import 'package:tution_app/pages/students/student_profile/main_details.dart';
import 'package:tution_app/pages/students/student_profile/parent_call_box.dart';
import 'package:tution_app/pages/students/student_profile/profile_head.dart';
import 'package:tution_app/pages/students/student_profile/student_attendace_chart.dart';

class StudentProfile extends StatefulWidget {
  final Student student;

  const StudentProfile({Key key, this.student}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  Student _student;

  @override
  void initState() {
    super.initState();
    _student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileHead(
              student: _student,
            ),
            MainDetails(student: _student,),
            _parentAttendanceBox(context),
            SizedBox(
              height: 5.0,
            ),
            _addCard(),
            _showClasses()
          ],
        ),
      ],
    );
  }


  Widget _parentAttendanceBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        children: <Widget>[
          ParentCallBox(student: _student,),
          SizedBox(
            width: 5.0,
          ),
          StudentAttendanceChart()
        ],
      ),
    );
  }







  Widget _addCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Container(
        child: Column(
          children: <Widget>[

            Container(
              alignment: Alignment.bottomLeft,
              height: 40.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Marking Cards",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),

            CardAdd()
          ],
        ),
      ),
    );
  }

  Widget _showClasses() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Color(0xffb59cdf),
        //   borderRadius: BorderRadius.circular(10.0)
        // ),

        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: 40.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Classes",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
            ClassListBox()
          ],
        ),
      ),
    );
  }
}

