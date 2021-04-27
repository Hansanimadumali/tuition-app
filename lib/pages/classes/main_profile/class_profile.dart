import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tution_app/pages/classes/main_profile/class_profile/class_circle_tile.dart';
import 'package:tution_app/pages/classes/main_profile/class_profile/class_main_title.dart';
import 'package:tution_app/pages/classes/main_profile/class_profile/class_teacher_tile.dart';
import 'package:tution_app/pages/classes/main_profile/class_profile/fair_container.dart';
import 'package:tution_app/services/class_service.dart';
import 'package:tution_app/state_mangement/classes/class_view/class_view_sm.dart';

class ClassProfile extends StatefulWidget {
  @override
  _ClassProfileState createState() => _ClassProfileState();
}

class _ClassProfileState extends State<ClassProfile> {
  ClassViewBloc get _classViewBloc => BlocProvider.of<ClassViewBloc>(context);

  final timeFormat = DateFormat("h:mm a");
  List<String> _dayList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  String _editDay;
  TimeOfDay _editStartTime = new TimeOfDay.now();
  TimeOfDay _editEndTime = new TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _editDay = "Sunday";
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        BlocBuilder(
            bloc: _classViewBloc,
            builder: (BuildContext context, ClassViewState state) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _createMainTitle(state),
                    _createCircleTiles(state),
                    _createTeacherTile(state),
                    _createStudentCard(),
                    _createNextNLastDateWidget(),
                    _createClassDates(),
                    _createFairWidget(state)
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget _createMainTitle(ClassViewState state) {
    if(state is ClassViewLoaded){
      return ClassMainTitle(tutionClass: state.tutionClass,);
    }
    return ClassMainTitle();
  }

  Widget _createFairWidget(ClassViewState state) {
    if(state is ClassViewLoaded) {
      return FairContainer(tutionClass: state.tutionClass);
    }
    return FairContainer();
  }


  Widget _createCircleTiles(ClassViewState state) {
    if(state is ClassViewLoaded) {
      return ClassCircleTile(tutionClass:state.tutionClass);
    }
    return ClassCircleTile();
  }


  Widget _createTeacherTile(ClassViewState state) {
    if(state is ClassViewLoaded){
      return ClassTeacherTile(tutionClass: state.tutionClass,);
    }
    return ClassTeacherTile();
  }



  Container _createClassDates() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
                child: Text(
              "Dates",
              style: TextStyle(fontSize: 25.0),
            )),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    _createClassDateTile(),
                    _createClassDateTile(),
                    _createClassDateTile(),
                    _createDayEditTile(),
                    _createDateAddButton(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _createDateAddButton() {
    return GestureDetector(
      onTap: () {
        // _shpwDateAddDialog();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 80.0,
          height: 30.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xff385170)),
          child: Center(
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Container _createClassDateTile() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: 100.0,
              child: Text(
                "Thursday",
                style: TextStyle(fontSize: 18.0),
              )),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "From",
                  style: TextStyle(fontSize: 12.0, color: Color(0xff385170)),
                ),
                Text(
                  "4.30 pm",
                  style: TextStyle(fontSize: 15.0),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("To",
                    style: TextStyle(fontSize: 12.0, color: Color(0xff385170))),
                Text("6.30 pm", style: TextStyle(fontSize: 15.0))
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xff385170)),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Icon(
                      Icons.edit,
                      color: Color(0xff385170),
                      size: 15.0,
                    )),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 15.0,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _createDayEditTile() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            // width: 100.0,
            child: DropdownButton(
              value: _editDay,
              items: _getDropDownMenuItems(),
              onChanged: (day) {
                setState(() {
                  _editDay = day;
                });
              },
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "From",
                  style: TextStyle(fontSize: 12.0, color: Color(0xff385170)),
                ),
                GestureDetector(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: Text(
                        createDateString(_editStartTime),
                        style: TextStyle(fontSize: 15.0, color: Colors.purple),
                      )),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "To",
                  style: TextStyle(fontSize: 12.0, color: Color(0xff385170)),
                ),
                GestureDetector(
                  onTap: () {
                    _selectEndTime(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Text(createDateString(_editEndTime),
                        style: TextStyle(fontSize: 15.0, color: Colors.purple)),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xff385170)),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Icon(
                      Icons.save,
                      color: Colors.blue,
                      size: 15.0,
                    )),
                Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xff385170)),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 15.0,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _editStartTime,
    );

    if (picked != null && picked != _editStartTime) {
      setState(() {
        _editStartTime = picked;
        if (_editEndTime.hour <= picked.hour) {
          _editEndTime =
              TimeOfDay(hour: picked.hour + 1, minute: _editEndTime.minute);
        }
      });
    }
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _editEndTime,
    );

    if (picked != null && picked != _editEndTime) {
      setState(() {
        _editEndTime = picked;
        if (_editStartTime.hour >= picked.hour) {
          _editStartTime =
              TimeOfDay(hour: picked.hour - 1, minute: _editStartTime.minute);
        }
      });
    }
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String day in _dayList) {
      items.add(new DropdownMenuItem(value: day, child: new Text(day)));
    }
    return items;
  }

  Container _createNextNLastDateWidget() {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff385170)),
          borderRadius: BorderRadius.circular(25.0)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Last class date"),
                  Text(
                    "2019-05-06",
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Next class date"),
                  Text(
                    "2019-05-06",
                    style: TextStyle(fontSize: 18.0, color: Colors.green),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _createStudentCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      child: Card(
        child: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("23", style: TextStyle(fontSize: 25.0)),
                      Text(
                        "Students",
                        style: TextStyle(fontSize: 13.0),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("18", style: TextStyle(fontSize: 25.0)),
                      Text(
                        "Last day attendance",
                        style: TextStyle(fontSize: 13.0),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 30.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                            color: Color(0xffececec),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                            child: Text("Add",
                                style: TextStyle(color: Color(0xff385170)))),
                      ),
                    ),
                    Container(
                      child: Container(
                        height: 30.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                            color: Color(0xffececec),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                            child: Text(
                          "View",
                          style: TextStyle(color: Color(0xff385170)),
                        )),
                      ),
                    ),
                    Text(
                      "Student Actions",
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}
