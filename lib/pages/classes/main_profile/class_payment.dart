import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:tution_app/models/payments_recieved.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/common_widgets/student_list_tile.dart';

class ClassPayment extends StatefulWidget {
  @override
  _ClassPaymentState createState() => _ClassPaymentState();
}

class _ClassPaymentState extends State<ClassPayment> {
  bool _paidSelected = true;
    List<dynamic> _payedList;
    List<dynamic> _notPayedList;

    void values() {
    _payedList = new List();
    _notPayedList = new List();
    _payedList.add(new Student.basic("1", "Kusal Janith", "Perera", 8));
    _payedList.add(new Student.basic("1", "Asela", "Gunarathna", 9));
    _payedList.add(new Student.basic("1", "Kusal", "Mendis", 8));
    _payedList.add(new Student.basic("1", "Jeewan", "Mendis", 9));
    _payedList.add(new Student.basic("1", "Dinesh", "Chandimal", 9));
    _payedList.add(new Student.basic("1", "Ajantha", "Mendis", 8));
    _payedList.add(new Student.basic("1", "Lasith", "Malinga", 8));
    _notPayedList.add(new Student.basic("1", "Suranga", "Lakmal", 10));
    _notPayedList.add(new Student.basic("1", "Malinga", "Bandara", 8));
    _notPayedList.add(new Student.basic("1", "Dimuth", "Karunaratne", 8));
    _notPayedList.add(new Student.basic("1", "Anjelo", "Perera", 8));
    _payedList[0].avatar =
        "http://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg";
  }



  static List<PaymentReceived> chartData = [
    new PaymentReceived("Received", 56, Colors.green),
    new PaymentReceived("Not Received", 10, Colors.redAccent)
  ];

  var series = [
    new charts.Series<PaymentReceived, String>(
      id: 'Payments',
      domainFn: (PaymentReceived payment, _) => payment.type,
      measureFn: (PaymentReceived payment, _) => payment.count,
      colorFn: (PaymentReceived payment, _) => payment.color,
      data: chartData,
    )
  ];

  @override
  Widget build(BuildContext context) {
    values();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        child: Column(
          children: <Widget>[
            _createDateListHeader(context),
            _createDashboardWidgets(),
            _paidTabBar(),
            SizedBox(height: 10.0,),
            _createStudentList()
          ],
        ),
      ),
    );
  }

  Expanded _createStudentList() {
    return Expanded(
            child: Container(
              child: _paidSelected? new ListView.builder(
                shrinkWrap: true,
                itemCount: _payedList.length,
                itemBuilder: (BuildContext context, int index){
                  Student student = _payedList[index];
                  return StudentListTile(student:student);
                },
              )
              : new ListView.builder(
                shrinkWrap: true,
                itemCount: _notPayedList.length,
                itemBuilder: (BuildContext context,int index){
                  Student student =_notPayedList[index];
                  return StudentListTile(student: student,);
                },
              )
            ),
          );
  }

  Container _paidTabBar() {
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
                if (!_paidSelected) {
                  setState(() {
                    _paidSelected = true;
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
                      color: _paidSelected
                          ? Color(0xff9fd3c7)
                          : Colors.transparent),
                  child: Center(
                    child: Text(
                      "Paid",
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff142d4c)),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_paidSelected) {
                  setState(() {
                    _paidSelected = false;
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
                      color: !_paidSelected
                          ? Color(0xffffbb9b)
                          : Colors.transparent),
                  child: Center(
                    child: Text(
                      "Not Paid",
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

  Container _createDashboardWidgets() {
    return Container(
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
                        "LKR",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "26000",
                        style: TextStyle(fontSize: 34.0, color: Colors.green),
                      ),
                    ],
                  ),
                  FlatButton(
                    child: Container(
                      height: 30.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xff142d4c)),
                      child: Center(
                        child: Text(
                          "Add Payment",
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
}

Container _createDateListHeader(BuildContext context) {
  return Container(
    height: 40.0,
    margin: const EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
        color: Color(0xffececec), borderRadius: BorderRadius.circular(20.0)),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              "Grade 10 OL Bwela",
              style: TextStyle(fontSize: 17.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xff9fd3c7),
              borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Center(
                child: Text(
              "June",
              style: TextStyle(fontSize: 17.0),
            )),
          ),
        )
      ],
    ),
  );
}

