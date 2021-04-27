import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/common_widgets/student_list_tile.dart';

class ClassDatePayment extends StatefulWidget {
  @override
  _ClassDatePaymentState createState() => _ClassDatePaymentState();
}

class _ClassDatePaymentState extends State<ClassDatePayment> {
  List<dynamic> _payedList;

  void values() {
    _payedList = new List();
    _payedList.add(new Student.basic("1", "Kusal Janith", "Perera", 8));
    _payedList.add(new Student.basic("1", "Asela", "Gunarathna", 9));
    _payedList.add(new Student.basic("1", "Kusal", "Mendis", 8));
    _payedList.add(new Student.basic("1", "Jeewan", "Mendis", 9));
    _payedList.add(new Student.basic("1", "Dinesh", "Chandimal", 9));
    _payedList.add(new Student.basic("1", "Ajantha", "Mendis", 8));
    _payedList.add(new Student.basic("1", "Lasith", "Malinga", 8));
    _payedList[0].avatar =
        "http://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg";
  }

  @override
  Widget build(BuildContext context) {
    values();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        child: Column(
          children: <Widget>[
            _createTopHeadboard(),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  Text("Payed Students",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            _createStudentList()
          ],
        ),
      ),
    );
  }

  Stack _createTopHeadboard() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffe1f2dc),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child:
                          Text("2019-06-30", style: TextStyle(fontSize: 28.0))),
                  _createClassName(),
                  _createMainCollection(),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100.0),
          height: 40.0,
          width: 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xff142d4c)),
          child: Center(
            child: Text(
              "Pay",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Expanded _createStudentList() {
    return Expanded(
      child: Container(
          child: new ListView.builder(
        shrinkWrap: true,
        itemCount: _payedList.length,
        itemBuilder: (BuildContext context, int index) {
          Student student = _payedList[index];
          return StudentListTile(student: student);
        },
      )),
    );
  }

  Container _createMainCollection() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "15000",
            style: TextStyle(fontSize: 65.0, color: Colors.green),
          ),
          Text("LKR", style: TextStyle(fontSize: 15.0))
        ],
      ),
    );
  }

  Container _createClassName() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.event,
                  size: 15.0,
                ),
                SizedBox(
                  width: 7.0,
                ),
                Container(
                  width: 120.0,
                  child: Text(
                    "Class OL bwala jhjkhk jjklj jjlkj",
                    // softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            child: Row(
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
        ),
      ],
    ));
  }
}
