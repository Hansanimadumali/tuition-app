import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/teacher.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';
 

class TeacherTile extends StatefulWidget {
  

  @override
  final Teacher teacher;

  const TeacherTile({Key key, this.teacher}) : super(key: key); 
  _TeacherTileState createState() => _TeacherTileState();
}


class _TeacherTileState extends State<TeacherTile> {
 
  final GlobalKey _keyRed = GlobalKey();
  Teacher _teacher;
  TeacherBloc get _teacherBloc => BlocProvider.of<TeacherBloc>(context);

  @override
  void initState(){
    this._teacher=widget.teacher;
    super.initState();
  }  

  @override
  void dispose(){
    _teacherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onLongPress: () {
          dynamic popUpMenuState =_keyRed.currentState;
          popUpMenuState.showButtonMenu();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          height: 50.0,
          child: Row(
            children: <Widget>[
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xff385170)),
                child: Center(
                  child: Text(
                    "SB",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
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
                      Text(_teacher.name,
                          style: TextStyle(
                              fontSize: 16.0, color: Color(0xff142d4c))),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        _teacher.telephone,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

              ),
              Container(
                child: PopupMenuButton(
                  key: _keyRed,
                  itemBuilder: (BuildContext context){
                    return [
                      PopupMenuItem(
                        child: Text("Edit"),
                        value: EditButtonPressed(_teacher),
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: DeleteButtonPressed(_teacher),
                      )
                    ];
                  },
                  onSelected: (event)=> _teacherBloc.dispatch(event),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}