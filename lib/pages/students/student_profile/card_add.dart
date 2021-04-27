import 'package:flutter/material.dart';

class CardAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0, bottom: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Color(0xff9fd3c7)),
      child: Row(
        children: <Widget>[
          Container(
            width: 60.0,
            decoration: BoxDecoration(
                color: Color(0xff142d4c),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0))),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
          Container(
              width: 60.0,
              decoration: BoxDecoration(
                color: Color(0xff385170),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "1",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                  Text("issued",
                      style: TextStyle(fontSize: 15.0, color: Colors.white))
                ],
              )),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Last used",
                    style: TextStyle(fontSize: 15.0, color: Color(0xff142d4c))),
                Text("25-10-2019",
                    style: TextStyle(fontSize: 25.0, color: Color(0xff142d4c)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
