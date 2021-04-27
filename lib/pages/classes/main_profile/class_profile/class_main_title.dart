import 'package:flutter/material.dart';
import 'package:tution_app/models/tution_class.dart';

class ClassMainTitle extends StatelessWidget {
  final TutionClass tutionClass;

  const ClassMainTitle({Key key, this.tutionClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(tutionClass!=null) {
      return _buildContainer();
    }
    return _loadingContainer();
  }

  Container _buildContainer() {
    return Container(
    child: Column(
      children: <Widget>[
        Container(
            child: Text(
          tutionClass.className,
          style: TextStyle(fontSize: 25.0),
          textAlign: TextAlign.center,
        )),
        Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: Icon(
                    Icons.location_on,
                    size: 15.0,
                  )),
              Text(tutionClass.institute.name +
                  ", " +
                  tutionClass.institute.location)
            ],
          ),
        )
      ],
    ),
  );
  }

  Container _loadingContainer() {
    return Container(
      height: 30.0,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
