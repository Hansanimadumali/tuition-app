import 'package:flutter/material.dart';
import 'package:tution_app/models/tution_class.dart';

class FairContainer extends StatelessWidget {
  final TutionClass tutionClass;

  const FairContainer({Key key, this.tutionClass}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (tutionClass!=null) {
      return _buildContainer();
    }
    return _loadingContainer();
  }

  Container _buildContainer() {
    return Container(
    margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: Text(
                "Payments",
                style: TextStyle(fontSize: 25.0),
              )),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 60.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tutionClass.classFee.toString(),
                          style: TextStyle(
                              fontSize: 25.0, color: Color(0xff385170)),
                        ),
                        Text("fee")
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 80.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tutionClass.instituteFee.toString(),
                          style: TextStyle(fontSize: 25.0, color: Colors.red),
                        ),
                        Text(
                          "institute fair",
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "15000",
                          style:
                          TextStyle(fontSize: 25.0, color: Colors.green),
                        ),
                        Text("this month payments")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
  }

  Container _loadingContainer(){
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
