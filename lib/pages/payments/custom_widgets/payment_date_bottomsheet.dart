import 'package:flutter/material.dart';

class PaymentDateBottomsheet extends StatefulWidget {
  PaymentDateBottomsheet({
    Key key,
  });

  @override
  _PaymentDateBottomsheetState createState() => _PaymentDateBottomsheetState();
}

class _PaymentDateBottomsheetState extends State<PaymentDateBottomsheet> {
  int _month;
  int _year;
  List<int> _yearList = [2018, 2019, 2020];
  List<int> _monthList = [1, 2, 3, 4, 5];
  List<String> _monthStringList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "Aughust",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: Container(
        height: 150.0,
        child: Column(
          children: <Widget>[
            _filterModelHeader(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<int>(
                    hint: new Text("Select Year"),
                    value: _year,
                    onChanged: (int newValue) {
                      setState(() {
                        _year = newValue;
                      });
                    },
                    items: _yearList.map((int value) {
                      return new DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 15.0,),
                  DropdownButton<int>(
                    hint: new Text("Select Month"),
                    value: _month,
                    onChanged: (int newValue) {
                      setState(() {
                        _month = newValue;
                      });
                    },
                    items: _monthList.map((int value) {
                      return new DropdownMenuItem<int>(
                        value: value,
                        child: Text(_monthStringList[value - 1].toString()),
                      );
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _filterModelHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                child: Text("Select Month",
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold))),
          ),
          FlatButton(
            child: Text(
              "Change",
              style: TextStyle(fontSize: 15.0, color: Color(0xff385170)),
            ),
            onPressed: () {
              // widget.setParentState(_searchGrade);
            },
          )
        ],
      ),
    );
  }
}
