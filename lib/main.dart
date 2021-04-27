import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/pages/root_page.dart';
import 'package:tution_app/repository/class_repository.dart';
import 'package:tution_app/repository/institute_repository.dart';
import 'package:tution_app/repository/student_repository.dart';
import 'package:tution_app/repository/subject_repository.dart';
import 'package:tution_app/repository/teacher_repository.dart';
import 'package:tution_app/repository/user_repository.dart';
import 'package:tution_app/services/authentication.dart';
import 'package:tution_app/state_mangement/classes/class_list/class_list_bloc_sm.dart';
import 'package:tution_app/state_mangement/classes/class_view/class_view_bloc.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';
import 'package:tution_app/state_mangement/simple_bloc_delegate.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';
import 'package:tution_app/state_mangement/users/authentication_sm.dart';

void main(){
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  final ClassRepository _classRepository = ClassRepository();
  AuthenticationBloc _authenticationBloc;

  InstituteBloc _instituteBloc;

  TeacherBloc _teacherBloc;

  SubjectBloc _subjectBloc;

  StudentListBloc _studentListBloc;

  ClassListBloc _classListBloc;

  ClassViewBloc _classViewBloc;

  @override
  void initState(){
    super.initState();
    _authenticationBloc =AuthenticationBloc(userRepository: _userRepository);
    _instituteBloc = InstituteBloc(instituteRepository: InstituteRepository());
    _teacherBloc = TeacherBloc(teacherRepository: TeacherRepository());
    _subjectBloc = SubjectBloc(subjectRepository: SubjectRepository());
    _studentListBloc = StudentListBloc(studentRepository: StudentRepository());
    _classListBloc = ClassListBloc(classRepository: _classRepository);
    _classViewBloc = ClassViewBloc(classRepository: _classRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc,),
        BlocProvider<InstituteBloc>(bloc: _instituteBloc),
        BlocProvider<TeacherBloc>(bloc: _teacherBloc),
        BlocProvider<SubjectBloc>(bloc: _subjectBloc),
        BlocProvider<StudentListBloc>(bloc: _studentListBloc,),
        BlocProvider<ClassListBloc>(bloc: _classListBloc,),
        BlocProvider<ClassViewBloc>(bloc: _classViewBloc,)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.purple,
          fontFamily: 'Roboto',
          brightness: Brightness.light,
          primaryColor: Color(0xff142d4c),
          accentColor: Color(0xff385170)
        ),
        home: new RootPage(auth: new Auth(),userRepository: _userRepository,),
      ),
    );
  }
}

