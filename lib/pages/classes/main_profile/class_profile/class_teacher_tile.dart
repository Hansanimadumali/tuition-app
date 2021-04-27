import 'package:flutter/material.dart';
import 'package:tution_app/models/tution_class.dart';

class ClassTeacherTile extends StatelessWidget {
  final TutionClass tutionClass;

  const ClassTeacherTile({Key key, this.tutionClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tutionClass != null) {
      return _buildContainer();
    }
    return _loadingContainer();
  }

  Container _buildContainer() {
    return Container(
      height: 30.0,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Color(0xff9fd3c7)),
      child: Row(
        children: <Widget>[
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xff142d4c)),
            child: Center(
                child: Text(
              _createNameInitial(tutionClass.teacher.name),
              style: TextStyle(color: Colors.white),
            )),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Text("By " + tutionClass.teacher.name,
                    style: TextStyle(color: Color(0xff142d4c))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _loadingContainer(){
    return Container(
      height: 40.0,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  String _createNameInitial(String name) {
    List<String> parts = name.split(" ");
    if (parts.length > 1) {
      return parts[0][0] + parts[1][0];
    }
    return name.substring(0, 2);
  }
}
