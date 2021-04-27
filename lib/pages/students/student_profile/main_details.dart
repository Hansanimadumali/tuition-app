import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';

class MainDetails extends StatelessWidget {
  final Student student;

  const MainDetails({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Text(
              student.firstName + " " + student.lastName,
              style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.grade,
                        color: Colors.black,
                      ),
                      Text(
                        "Grade " + student.grade.toString(),
                        style: TextStyle(fontSize: 13.0),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.school,
                        color: Colors.black,
                      ),
                      Text(student.school,
                          style: TextStyle(fontSize: 13.0),
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "2",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Classes",
                        style: TextStyle(fontSize: 13.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
