import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/teacher.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';
  

class TeacherAddTile extends StatefulWidget {
  final Teacher teacher;

  const TeacherAddTile({Key key,  this.teacher}) : super(key: key);
  @override
  _TeacherAddTileState createState() => _TeacherAddTileState();
}

class _TeacherAddTileState extends State<TeacherAddTile> {
  final _teacherNameController = TextEditingController();
  final _teacherTelephoneController = TextEditingController();
  Teacher _teacher;

  TeacherBloc get _teacherBloc => BlocProvider.of<TeacherBloc>(context);

  @override
  void initState() {
    super.initState();
    if(widget.teacher!=null){
      _teacher =widget.teacher;
      _teacherNameController.text =widget.teacher.name;
      _teacherTelephoneController.text =widget.teacher.telephone;
    }
  }

  @override
  void dispose() {
    _teacherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xffececec)),
                child: Center(
                  child: Icon(Icons.camera_alt),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      _teachersNameInput(),
                      _teachersNumberInput()
                    ],
                  ),
                ),
              ),
              Container(
                width: 60,
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.save,
                        color: Colors.blue,
                        size: 17.0,
                      ),
                      onPressed: () {
                        _teacherBloc.dispatch(SaveButtonPressed(
                            id: _teacher!=null?_teacher.id:null,
                            name: _teacherNameController.text,
                            telephone: _teacherTelephoneController.text));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 17.0,
                      ),
                      onPressed: () {
                        _teacherBloc.dispatch(CancelButtonPressed());
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    
  }

  TextFormField _teachersNameInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _teacherNameController,
      decoration: const InputDecoration(
          hintText: 'Teacher\'s name',
          labelText: 'Name',
          contentPadding: EdgeInsets.symmetric(vertical: 5.0)),
      validator: (String value) {
        if (value.contains('@')) {
          return 'Do not use the @ char.';
        } else if (value.length < 4) {
          return 'Give a meaningful name';
        }
        return null;
      },
    );
  }

  TextFormField _teachersNumberInput() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _teacherTelephoneController,
      decoration: const InputDecoration(
          hintText: 'Teacher\'s Number',
          labelText: 'Telephone',
          contentPadding: EdgeInsets.symmetric(vertical: 5.0)),
      validator: (String value) {
        if (value.length > 10) {
          return 'Number must be less than 10 digits';
        } else if (value.length < 10) {
          return 'Number must be 10 digits long';
        }
        return null;
      },
    );
  }
}
