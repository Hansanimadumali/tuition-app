import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/common_widgets/student_list_tile.dart';

class ClassDateAttendance extends StatefulWidget {
  @override
  _ClassDateAttendanceState createState() => _ClassDateAttendanceState();
}

class _ClassDateAttendanceState extends State<ClassDateAttendance> {
  bool _participated = true;
  List<dynamic> _participatedList;
  List<dynamic> _notParticipatedList;

  void values() {
    _participatedList = new List();
    _notParticipatedList = new List();
    _participatedList.add(new Student.basic("1", "Kusal Janith", "Perera", 8));
    _participatedList.add(new Student.basic("1", "Asela", "Gunarathna", 9));
    _participatedList.add(new Student.basic("1", "Kusal", "Mendis", 8));
    _participatedList.add(new Student.basic("1", "Jeewan", "Mendis", 9));
    _participatedList.add(new Student.basic("1", "Dinesh", "Chandimal", 9));
    _participatedList.add(new Student.basic("1", "Ajantha", "Mendis", 8));
    _participatedList.add(new Student.basic("1", "Lasith", "Malinga", 8));
    _notParticipatedList.add(new Student.basic("1", "Suranga", "Lakmal", 10));
    _notParticipatedList.add(new Student.basic("1", "Malinga", "Bandara", 8));
    _notParticipatedList.add(new Student.basic("1", "Dimuth", "Karunaratne", 8));
    _notParticipatedList.add(new Student.basic("1", "Anjelo", "Perera", 8));
    _participatedList[0].avatar =
        "http://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg";
  }

  static List<Participation> chartData = [
    new Participation("Participated", 24, Colors.green),
    new Participation("Not Particpated", 6, Colors.red)
  ];

  var series = [
    new charts.Series<Participation, String>(
        id: "Participation",
        domainFn: (Participation participation, _) => participation.type,
        measureFn: (Participation participation, _) => participation.count,
        colorFn: (Participation participation, _) => participation.color,
        data: chartData)
  ];

  @override
  Widget build(BuildContext context) {
    values();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        child: Column(
          children: <Widget>[
            _createClassName(),
            _createAttendanceDashboard(),
            _participatedTabBar(),
            SizedBox(
              height: 10.0,
            ),
            _createStudentList()
          ],
        ),
      ),
    );
  }

  Container _createClassName() {
    return Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.event,
                size: 15.0,
              ),
              SizedBox(width: 7.0,),
              Text(
                "Class OL bwala",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.start,
              ),
            ],
          ));
  }

  Expanded _createStudentList() {
    return Expanded(
      child: Container(
          child: _participated
              ? new ListView.builder(
                  shrinkWrap: true,
                  itemCount: _participatedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Student student = _participatedList[index];
                    return StudentListTile(student: student);
                  },
                )
              : new ListView.builder(
                  shrinkWrap: true,
                  itemCount: _notParticipatedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Student student = _notParticipatedList[index];
                    return StudentListTile(
                      student: student,
                    );
                  },
                )),
    );
  }

  Container _createAttendanceDashboard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Color(0xffe1f2dc),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Row(
        children: <Widget>[
          Container(
            
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  child: charts.PieChart(
                    series,
                    animate: false,
                    defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 10,
                      arcRendererDecorators: [
                        new charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside)
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text("56",
                          style: TextStyle(fontSize: 30.0, color: Colors.blue)),
                      Text(
                        "62",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "2019-06-30",
                        style: TextStyle(fontSize: 34.0, color: Colors.green),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text("5.30 pm - 6.30 pm")
                      ],
                    ),
                  ),
                  FlatButton(
                    child: Container(
                      height: 30.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xff142d4c)),
                      child: Center(
                        child: Text(
                          "Mark",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("pressed add payment");
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _participatedTabBar() {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: Color(0xffececec),
        borderRadius: BorderRadius.circular(15.0),
        // border: Border.all(color: Color(0xff385170))
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!_participated) {
                  setState(() {
                    _participated = true;
                  });
                }
              },
              child: Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      ),
                      color: _participated
                          ? Color(0xff9fd3c7)
                          : Colors.transparent),
                  child: Center(
                    child: Text(
                      "Participated",
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff142d4c)),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_participated) {
                  setState(() {
                    _participated = false;
                  });
                }
              },
              child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      color: !_participated
                          ? Color(0xffffbb9b)
                          : Colors.transparent),
                  child: Center(
                    child: Text(
                      "Not Participated",
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff142d4c)),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class Participation {
  final String type;
  final int count;
  final charts.Color color;

  Participation(this.type, this.count, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
