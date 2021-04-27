import 'package:flutter/material.dart';
import 'package:tution_app/models/teacher.dart';
import 'package:tution_app/pages/drawer/teacher_page_widgets/teacher_add_tile.dart';
import 'package:tution_app/pages/drawer/teacher_page_widgets/teacher_tile.dart';
import 'package:tution_app/repository/teacher_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';

class TeacherPage extends StatefulWidget {

  final TeacherBloc teacherBloc;

  const TeacherPage({Key key,@required this.teacherBloc}) : super(key: key);

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  TeacherBloc _teacherBloc;

  @override
  void initState() {
    _teacherBloc = widget.teacherBloc;
    _teacherBloc.dispatch(LoadTeachers());
    super.initState();
  }

  @override
  void dispose() {
    _teacherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeacherBloc>(
      bloc: _teacherBloc,
      child: Scaffold(
        appBar: _createAppBar(),
        body: BlocListener(
          bloc: _teacherBloc,
          listener: (BuildContext context, TeacherState state){
            if(state is TeacherLoading){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Loading ..."),
                        CircularProgressIndicator()
                      ],
                    ),
                  )
                );
            }
            if(state is TeacherLoadingError){
               Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text("Load Failure"),Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                )
              );
            }
            if(state is SuccessfulSubmission){
              _teacherBloc.dispatch(LoadTeachers());
            }
          },
          child: BlocBuilder(
            bloc: _teacherBloc,
            builder: (BuildContext context,TeacherState state){
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: _createTileList(state),
                    )
                  ),
                  _showDeleteDialog(state)
                ],
              );
            }
          )
    )));
  }

  Widget _showDeleteDialog(TeacherState state) {
    if(state is DeleteConfirmation){
      return AlertDialog(
        title: new Text("Delete ${state.teacher.name}"),
        content: new Text("Press confirm to delete the teacher"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              _teacherBloc.dispatch(CancelButtonPressed());
            },
          ),
          new FlatButton(
            child: new Text(
              "Confirm",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              _teacherBloc
                  .dispatch(DeleteConfirmationButtonPressed(state.teacher));
            },
          ),
        ],
      );
    }
    return Container();
  }

  List<Widget> _createTileList(TeacherState state){
    List<Widget> list = new List();
    if(state is TeacherLoaded){
      for(Teacher teacher in state.teachers){
        list.add(TeacherTile(teacher: teacher,key: Key(teacher.id),));
      }
    }

    if(state is TeacherAdd){
      list.add(TeacherAddTile());
      for(Teacher teacher in state.teachers){
        list.add(TeacherTile(teacher: teacher,key: Key(teacher.id),));
      }
    }

    if(state is TeacherEdit){
      for(Teacher teacher in state.teachers){
        if(teacher.id==state.id){
          list.add(TeacherAddTile(teacher: teacher,key: Key(teacher.id),));
        }else{
          list.add(TeacherTile(teacher: teacher, key: Key(teacher.id),));
        }
      }
    }

    if(state is DeleteConfirmation){
      for(Teacher teacher in state.teachers){
        list.add(TeacherTile(teacher: teacher,key: Key(teacher.id),));
      }
    }
    
    return list;
    
  }



  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "Teachers",
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      iconTheme: new IconThemeData(color: Colors.blue),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 32.0,
          ),
          onPressed: () {
            _teacherBloc.dispatch(AddButtonPressed());
          },
        )
      ],
    );
  }
}
