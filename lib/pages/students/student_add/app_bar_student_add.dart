import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/state_mangement/students/student_crud/student_crud_bloc.dart';
import 'package:tution_app/state_mangement/students/student_crud/student_crud_sm.dart';

class AppBarStudentAdd extends StatelessWidget implements PreferredSizeWidget {
  final StudentCrudBloc studentCrudBloc;
  final bool isPopulated;
  final Function onDataSaved;

  const AppBarStudentAdd(
      {Key key, this.studentCrudBloc, this.isPopulated, this.onDataSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: new Text("Add Student", style: new TextStyle(color: Colors.black)),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: Colors.black),
      actions: <Widget>[
        Container(
          child: BlocBuilder(
              bloc: studentCrudBloc,
              builder: (BuildContext context, StudentAddState state) {
                return Container(
                  child: FlatButton(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: isSubmitButtonEnabled(state)
                              ? Colors.blue
                              : Colors.grey,
                          fontSize: 18.0),
                    ),
                    onPressed: () {
                      if (isSubmitButtonEnabled(state)) {
                        onDataSaved();
                      }
                    },
                  ),
                );
              }),
        )
      ],
    );
  }

  bool isSubmitButtonEnabled(StudentAddState state) {
    return isPopulated && state.isFormValid && !state.isSubmitting;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}
