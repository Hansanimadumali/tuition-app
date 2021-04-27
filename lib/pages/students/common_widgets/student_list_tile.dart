import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/students_pages.dart';
import 'package:tution_app/services/student_service.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';

class StudentListTile extends StatefulWidget {
  const StudentListTile({Key key, this.student}) : super(key: key);

  final Student student;

  @override
  _StudentListTileState createState() => _StudentListTileState();
}

class _StudentListTileState extends State<StudentListTile> {
  Student _student;

  StudentListBloc get _studentListBloc =>
      BlocProvider.of<StudentListBloc>(context);

  @override
  void initState() {
    super.initState();
    _student = widget.student;
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _studentListBloc,
        builder: (BuildContext context, StudentListState state) {
          return GestureDetector(
            onTap: () {
              if (state is StudentListLoaded) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentPages(
                              student: _student,
                            )));
              }
              if (state is StudentMultipleSelectList) {
                _studentListBloc.dispatch(
                    SelectMultipleStudents(student: _student));
              }
            },
            onLongPress: () {
              if (state is StudentListLoaded) {
                _studentListBloc.dispatch(
                    SelectMultipleStudents(student: _student));
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                  color: _checkSelected(state)
                      ? Colors.black.withOpacity(0.1)
                      : Colors.transparent
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      _createAvatar(_student),
                      SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                _student.firstName +
                                    " " +
                                    _student.lastName,
                                style: TextStyle(fontSize: 16.0)),
                            Text(
                              "Grade " + _student.grade.toString(),
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xff385170)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      _createSelectItem(state),
                      SizedBox(width: 15.0,)
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container _createAvatar(Student student) {
    if (student.avatar == null) {
      String nameInitials = createNameInitials(student);
      return Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            color: Color(0xff385170),
            borderRadius: BorderRadius.circular(40.0)),
        child: Center(
          child: Text(nameInitials,
              style: TextStyle(color: Colors.white, fontSize: 17.0)),
        ),
      );
    }

    return Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            color: Color(0xffececec),
            borderRadius: BorderRadius.circular(40.0)),
        child: ClipOval(
          child: Image(
            image: NetworkImage(student.avatar),
            height: 40.0,
            width: 40.0,
            fit: BoxFit.cover,
          ),
        ));
  }


  bool _checkSelected(StudentListState state) {
    if (state is StudentMultipleSelectList) {
      if (state.selectedStudents.contains(_student)) {
        return true;
      }
    }
    return false;
  }

  Widget _createSelectItem(StudentListState state) {
    if (state is StudentMultipleSelectList) {
      if (_checkSelected(state)) {
        return Icon(Icons.check_box, color: Color(0xff385170),);
      } else {
        return Icon(Icons.check_box_outline_blank, color: Color(0xff385170),);
      }
    }
    return Container();
  }
}
