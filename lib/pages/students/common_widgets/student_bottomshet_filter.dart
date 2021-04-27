import 'package:flutter/material.dart';

class StudentBottomSheetFilter extends StatefulWidget {
  StudentBottomSheetFilter({Key key, this.setParentState,this.grade}):super(key:key); 

  final Function(int) setParentState;
  final int grade;

  @override
  _StudentBottomSheetFilterState createState() => _StudentBottomSheetFilterState();
}

class _StudentBottomSheetFilterState extends State<StudentBottomSheetFilter> {
  List<int> gradeList = [6, 7, 8, 9, 10, 11];
  int _searchGrade = -1;

  @override
  void initState(){
    super.initState();
    setState(() {
      this._searchGrade=widget.grade;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: Container(
        height: 150.0,
        child: Column(
          children: <Widget>[
            _filterModelHeader(),
            _createGradeFilterSet()
          ],
        ),
      ),
    );
  }

   Container _createGradeFilterSet() {
    return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Grade",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: _createGradeRadioButtons()),
                    )
                  ],
                ),
              );
  }

  List<Widget> _createGradeRadioButtons() {
    return gradeList
        .map((grade) => new Column(
              children: <Widget>[
                new Radio<int>(
                  value: grade,
                  groupValue: _searchGrade,
                  onChanged: (int value) {
                    setState(() {
                      _searchGrade = value;
                    });
                  },
                ),
                new Text(grade.toString())
              ],
            ))
        .toList();
  }

  Container _filterModelHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                child: Text("Filter Student",
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
              setState(() {
                      _searchGrade = -1;
                      widget.setParentState(_searchGrade);
              },
              );

            },

          ),
          FlatButton(
            child: Text(
              "FILTER",
              style: TextStyle(fontSize: 15.0, color: Color(0xff385170)),
            ),
            onPressed: () {
                widget.setParentState(_searchGrade);
            },
          )
        ],
      ),
    );
  }
}