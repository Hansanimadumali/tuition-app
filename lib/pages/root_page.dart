import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/pages/home_page.dart';
import 'package:tution_app/pages/login/loginpage.dart';
import 'package:tution_app/pages/splash_screen.dart';
import 'package:tution_app/repository/user_repository.dart';
import 'package:tution_app/services/authentication.dart';
import 'package:tution_app/state_mangement/classes/class_list/class_list_bloc_sm.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';
import 'package:tution_app/state_mangement/users/authentication_sm.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth, this.userRepository});

  final UserRepository userRepository;
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthenticationBloc get _authenticationBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  InstituteBloc get _instituteBloc => BlocProvider.of<InstituteBloc>(context);

  TeacherBloc get _teacherBloc => BlocProvider.of<TeacherBloc>(context);

  SubjectBloc get _subjectBloc => BlocProvider.of<SubjectBloc>(context);

  StudentListBloc get _studentListBloc =>
      BlocProvider.of<StudentListBloc>(context);

  ClassListBloc get _classListBloc => BlocProvider.of<ClassListBloc>(context);

  @override
  void initState() {
    super.initState();
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Authenticated) {
          initBlocDataAfterAuthentication();
          return MyHomePage(
            userId: state.displayName,
          );
        }
        if (state is Unauthenticated) {
          return LoginPage(userRepository: widget.userRepository);
        }
      },
    );
  }

  void initBlocDataAfterAuthentication() {
    // load initial data
    _teacherBloc.dispatch(LoadTeachers());
    _instituteBloc.dispatch(LoadInstitutes());
    _subjectBloc.dispatch(LoadSubjects());
    _studentListBloc.dispatch(LoadStudentList());
    _classListBloc.dispatch(LoadClassList());
  }
}
