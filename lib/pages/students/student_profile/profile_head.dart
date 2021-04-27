import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/student_profile/profile_avatar.dart';
import 'package:tution_app/services/student_service.dart';

class ProfileHead extends StatelessWidget {
  final Student student;

  const ProfileHead({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ProfileAvatar(
              student: student,
            ),
            Container(
              height: 30.0,
              width: 30.0,
              margin: const EdgeInsets.only(bottom: 70.0, left: 100.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.orangeAccent),
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 15.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: _textStudent,
              // behavior: HitTestBehavior.translucent,
              child: Container(
                height: 40.0,
                width: 40.0,
                margin: const EdgeInsets.only(top: 75.0, right: 180.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.transparent,
                    border: new Border.all(color: Color(0xff142d4c))),
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Color(0xff142d4c),
                    size: 15.0,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _callStudent,
              // behavior: HitTestBehavior.translucent,
              child: Container(
                height: 40.0,
                width: 40.0,
                margin: const EdgeInsets.only(top: 75.0, left: 180.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.transparent,
                    border: new Border.all(color: Color(0xff142d4c))),
                child: Center(
                  child: Icon(
                    Icons.call,
                    color: Color(0xff142d4c),
                    size: 15.0,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  void _callStudent() {
    makeCall(student.mobile);
  }

  void _textStudent() {
    sendMessage(student.mobile);
  }
}
