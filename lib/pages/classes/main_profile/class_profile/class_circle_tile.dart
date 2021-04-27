import 'package:flutter/material.dart';
import 'package:tution_app/models/tution_class.dart';

class ClassCircleTile extends StatelessWidget {
  final TutionClass tutionClass;

  const ClassCircleTile({Key key, this.tutionClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(tutionClass != null) {
      return _buildContainer();
    }
    return _loadingContainer();
  }

  Padding _buildContainer() {
    return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
    child: Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff142d4c),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Center(
                        child: Text(tutionClass.grade.toString(),
                            style: TextStyle(
                                fontSize: 25.0, color: Color(0xff142d4c))),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Grade", style: TextStyle(fontSize: 13.0))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff142d4c),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Center(
                        child: Text(tutionClass.subject.name[0].toUpperCase(),
                            style: TextStyle(
                                fontSize: 25.0, color: Color(0xff142d4c))),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(tutionClass.subject.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.0))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff142d4c),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Center(
                        child: Text(tutionClass.medium[0],
                            style: TextStyle(
                                fontSize: 25.0, color: Color(0xff142d4c))),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Medium", style: TextStyle(fontSize: 13.0))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
  }

  Container _loadingContainer(){
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Lading class details")
          ],
        ),
      ),
    );
  }

}
