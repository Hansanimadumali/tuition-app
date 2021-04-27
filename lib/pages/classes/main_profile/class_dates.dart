import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tution_app/pages/classes/custom_widgets/tution_class_date_filter.dart';
import 'package:tution_app/pages/classes/single_class_date/single_class_date_pages.dart';
import 'package:tution_app/services/class_service.dart';

class ClassDates extends StatefulWidget {
  @override
  _ClassDatesState createState() => _ClassDatesState();
}

class _ClassDatesState extends State<ClassDates> {
  bool _editNextDate = false;
  DateTime _classDateEdit = new DateTime.now();
  TimeOfDay _startTimeEdit = TimeOfDay.now();
  TimeOfDay _endTimeEdit = TimeOfDay.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createDateListHeader(context),
            Text("Next Date"),
            _editNextDate ? _createNextDateEditTile() : _createNextDateTile(),
            Text("Previous Dates"),
            _createLastDateList()
          ],
        ),
      ),
    );
  }

  Card _createNextDateTile() {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SingleClassDatePages()));
        },
        child: Container(
          height: 80.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 50.0,
                  child: Center(
                    child: Icon(
                      Icons.event,
                      color: Color(0xff9fd3c7),
                    ),
                  )),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "2017-05-30",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "From",
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("7.30 pm")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "To",
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("10.30 pm")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text("Attendance :",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.green)),
                              Text(
                                "23",
                                style: TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text("Payments :",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.green)),
                              Text(
                                "2300 lkr",
                                style: TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 20.0,
                        ),
                        onPressed: () {
                          if (!_editNextDate) {
                            setState(() {
                              _editNextDate = true;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20.0,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Card _createNextDateEditTile() {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 50.0,
                child: Center(
                  child: Icon(
                    Icons.event,
                    color: Color(0xff9fd3c7),
                  ),
                )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _selectClassDate(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: Text(
                        formatter.format(_classDateEdit),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "From",
                                style: TextStyle(fontSize: 10.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectStartTime(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child:
                                        Text(createDateString(_startTimeEdit))),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "To",
                                style: TextStyle(fontSize: 10.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectEndTime(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child:
                                        Text(createDateString(_endTimeEdit))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.save,
                        color: Colors.blue,
                        size: 20.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 20.0,
                      ),
                      onPressed: () {
                        if (_editNextDate) {
                          setState(() {
                            _editNextDate = false;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _createLastDateList() {
    return Expanded(
      child: Container(
        child: ListView(
          children: <Widget>[
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
            _createLastDateTile(),
          ],
        ),
      ),
    );
  }

  Card _createLastDateTile() {
    return Card(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SingleClassDatePages()));
        },
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Container(
                  width: 50.0,
                  child: Center(
                    child: Icon(
                      Icons.event,
                      color: Color(0xff142d4c),
                    ),
                  )),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "2017-05-26",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text("Attendance :",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red)),
                              Text(
                                "23",
                                style: TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text("Payments :",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red)),
                              Text(
                                "2300 lkr",
                                style: TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 7.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "From",
                              style: TextStyle(fontSize: 10.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("5.30 pm")
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("To", style: TextStyle(fontSize: 10.0)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("7.30 pm")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
            width: 40.0,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: Color(0xff142d4c),
                ),
                onPressed: () {
                  _filterModalBottomSheet(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _filterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return TutionClassDateFilter();
        });
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _startTimeEdit,
    );

    if (picked != null && picked != _startTimeEdit) {
      setState(() {
        _startTimeEdit = picked;
        if (_endTimeEdit.hour <= picked.hour) {
          _endTimeEdit =
              TimeOfDay(hour: picked.hour + 1, minute: _endTimeEdit.minute);
        }
      });
    }
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _endTimeEdit,
    );

    if (picked != null && picked != _endTimeEdit) {
      setState(() {
        _endTimeEdit = picked;
        if (_startTimeEdit.hour >= picked.hour) {
          _startTimeEdit =
              TimeOfDay(hour: picked.hour - 1, minute: _startTimeEdit.minute);
        }
      });
    }
  }

  Future<Null> _selectClassDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _classDateEdit,
      firstDate: new DateTime(2017),
      lastDate: new DateTime(2021),
    );

    if (picked != null && picked != _classDateEdit) {
      setState(() {
        _classDateEdit = picked;
      });
    }
  }
}
