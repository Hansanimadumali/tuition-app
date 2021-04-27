import 'package:flutter/material.dart';

class StudentAttendance extends StatefulWidget {
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
          child: Column(
        children: <Widget>[
          _getHeading(context),
          SizedBox(
            height: 8.0,
          ),
          _getAttendedList()
        ],
      )),
    );
  }

  void _filterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Text("Hello"),
          );
        });
  }

  Widget _getHeading(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Color(0xffececec), borderRadius: BorderRadius.circular(25.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50,
            child: Center(
                child: Text(
              "JD",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )),
            decoration: BoxDecoration(
              color: Color(0xff142d4c),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          Container(
              child: Center(
            child: Text(
              "Kusal",
              style: TextStyle(fontSize: 18.0),
            ),
          )),
          Container(
            width: 50,
            child: Center(
                child: IconButton(
              color: Color(0xff142d4c),
              onPressed: () {
                _filterModalBottomSheet(context);
              },
              icon: Icon(Icons.tune),
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAttendedList() {
    return Expanded(
      child: Container(
        child: ListView(
          children: <Widget>[
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
            new _createDateCard(),
          ],
        ),
      ),
    );
  }
}

class _createDateCard extends StatelessWidget {
  const _createDateCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.0,
              child: Icon(Icons.event),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Grade 7 nema"),
                  Row(
                    children: <Widget>[
                      Text("27 May 2018", style: TextStyle(fontSize: 12.0)),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("|"),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text("13:56", style: TextStyle(fontSize: 12.0))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _filterWindow() {
    return new Column(
      children: <Widget>[],
    );
  }
}
