import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/pages/drawer/institute_page.dart';
import 'package:tution_app/pages/drawer/subject_page.dart';
import 'package:tution_app/pages/drawer/teacher_page.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_bloc.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_bloc.dart';
import 'package:tution_app/state_mangement/users/authentication_sm.dart';

class DrawerContainer extends StatefulWidget {
  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            "John Doe",
            style: TextStyle(fontSize: 25.0),
          ),
          // accountEmail: Text("sanjeewa@abc.com"),
        ),
        Expanded(
          child: Container(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Teachers",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  leading: Icon(Icons.people),
                  trailing: Chip(
                    label: Text("3"),
                  ),
                  onTap: () {
                    TeacherBloc teacherBloc = BlocProvider.of<TeacherBloc>(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TeacherPage(teacherBloc: teacherBloc,)));
                  },
                ),
                ListTile(
                  title: Text(
                    "Institutes",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  leading: Icon(Icons.school),
                  trailing: Chip(
                    label: Text("3"),
                  ),
                  onTap: () {
                    InstituteBloc _instituteBloc = BlocProvider.of<InstituteBloc>(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstitutePage(
                                  instituteBloc: _instituteBloc
                                )));
                  },
                ),
                ListTile(
                  title: Text(
                    "Subjects",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  leading: Icon(Icons.school),
                  trailing: Chip(
                    label: Text("6"),
                  ),
                  onTap: () {
                    SubjectBloc subjectBloc = BlocProvider.of<SubjectBloc>(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SubjectPage(subjectBloc: subjectBloc,)));
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .dispatch(LoggedOut());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  height: 40.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      color: Color(0xff385170),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.lock, color: Colors.white, size: 13.0),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "SignOut",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
