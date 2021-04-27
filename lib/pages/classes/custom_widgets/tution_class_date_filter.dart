import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TutionClassDateFilter extends StatefulWidget {
  @override
  _TutionClassDateFilterState createState() => _TutionClassDateFilterState();
}

class _TutionClassDateFilterState extends State<TutionClassDateFilter> {
  String _searchDay = "Day";
  List<String> _dayList = [
    "Day",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  DateTime _startDate = new DateTime.now();
  DateTime _endDate = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,8.0),
      child: Container(
        height: 200.0,
        child:Column(
          children: <Widget>[
            _filterModelHeader(),
            Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: Text("Week Day : ",style: TextStyle(fontSize: 16.0),)),
                Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isDense: true,
                      value: _searchDay,
                      items: _getDropDownDayList(),
                      onChanged: (day) {
                        setState(() {
                            _searchDay =day;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: Text("Start Date : ",style: TextStyle(fontSize: 16.0),)),
                Container(
                  child:Text(formatter.format(_startDate),style: TextStyle(fontSize: 16.0,color: Colors.purple),)
                ),
                Container(
                  child: FlatButton(
                    child: Text("change"),
                    onPressed: (){
                      _selectStartDate(context);
                    },
                  ),
                )
              ],
            ),
          ),

           Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: Text("End Date : ",style: TextStyle(fontSize: 16.0),)),
                Container(
                  child:Text(formatter.format(_endDate),style: TextStyle(fontSize: 16.0,color: Colors.purple),)
                ),
                Container(
                  child: FlatButton(
                    child: Text("change"),
                    onPressed: (){
                      _selectEndDate(context);
                    },
                  ),
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
                child: Text("Filter Class Date",
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold))),
          ),
          FlatButton(
            child: Text("CLEAR",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red,
                )),
            onPressed: () {
              _searchDay =null;
            },

          ),
          FlatButton(
            child: Text(
              "FILTER",
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

 List<DropdownMenuItem<String>> _getDropDownDayList() {
    List<DropdownMenuItem<String>> items = new List();
    for (String day in _dayList) {
      items.add(new DropdownMenuItem(value: day, child: new Text(day)));
    }
    return items;
  }

  Future<Null> _selectStartDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: new DateTime(2017),
      lastDate: new DateTime(2021)
    );

    if(picked != null && picked !=_startDate && picked.isBefore(_endDate)){
      setState(() {
        _startDate =picked;
      });
    }
  }


  Future<Null> _selectEndDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: new DateTime(2017),
      lastDate: new DateTime(2021)
    );

    if(picked != null && picked !=_endDate && picked.isAfter(_startDate)){
      setState(() {
        _endDate =picked;
      });
    }
  }

}