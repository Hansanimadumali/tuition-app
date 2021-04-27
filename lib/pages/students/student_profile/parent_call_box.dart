import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/services/student_service.dart';

class ParentCallBox extends StatelessWidget {
  final Student student;

  const ParentCallBox({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130.0,
        decoration: BoxDecoration(
            color: Color(0xff9fd3c7),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 40.0,
              width: double.infinity,
              child: Text("Parent",
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              decoration: BoxDecoration(
                  color: Color(0xff385170),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onLongPress: () {
                  _callParent();
                },
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      color: Color(0xff385170),
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(student.parentType,
                        style: TextStyle(
                            color: Color(0xff385170), fontSize: 16.0)),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(student.parentMobile,
                        style:
                            TextStyle(color: Color(0xff385170), fontSize: 14.0))
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _callParent() {
    makeCall(student.parentMobile);
  }
}
