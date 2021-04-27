import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/common_widgets/student_list_tile.dart';
import 'package:tution_app/pages/students/student_list/search_bar.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';

import '../student_add/student_add.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  StudentListBloc get _studentListBloc =>
      BlocProvider.of<StudentListBloc>(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _studentListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentListBloc>(
      bloc: _studentListBloc,
      child: new Scaffold(
          body: BlocListener(
            bloc: _studentListBloc,
            listener: (BuildContext context, StudentListState state) {
              if (state is StudentListLoading) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Loading ..."),
                        CircularProgressIndicator()
                      ],
                    ),
                  ));
              }
              if (state is StudentListLoadingError) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Load Failure"),
                        Icon(Icons.error)
                      ],
                    ),
                    backgroundColor: Colors.red,
                  ));
              }
              if (state is LoadingToAddScreen) {
                _loadStudentList();
                _navigateToAddPage(context);
              }
              if (state is SuccessfulSubmission) {
                _studentListBloc.dispatch(LoadStudentList());
              }
            },
            child: BlocBuilder(
                bloc: _studentListBloc,
                builder: (BuildContext context, StudentListState state) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: _createBody(state),
                        ),
                      )
                    ],
                  );
                }),
          ),
          floatingActionButton: BlocBuilder(
              bloc: _studentListBloc,
              builder: (BuildContext context, StudentListState state) {
                if (state is StudentListLoaded) {
                  return FloatingActionButton(
                    onPressed: () {
                      _studentListBloc.dispatch(NavigateAddScreen());
                    },
                    tooltip: 'Add Student',
                    child: Icon(Icons.add),
                  );
                }
                if (state is StudentMultipleSelectList) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          _studentListBloc.dispatch(DeleteMultiple());
                        },
                        tooltip: 'Delete Selected',
                        child: Icon(Icons.delete),
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          _studentListBloc.dispatch(CancelSelectMultiple());
                        },
                        tooltip: 'Cancel Selected',
                        child: Icon(
                          Icons.clear,
                          size: 30.0,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                      ),
                    ],
                  );
                }
                return Container();
              })),
    );
  }

  Widget _createBody(StudentListState state) {
    return Column(
      children: <Widget>[SearchBar(), _createStudentList(state)],
    );
  }

  Future<Null> _onRefresh() async {
    _studentListBloc.dispatch(LoadStudentList());
  }

  Future<Null> _navigateToAddPage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                StudentAdd(
                  studentListBloc: _studentListBloc,
                )));
  }

  Widget _createStudentList(StudentListState state) {
    if (state is StudentListLoaded ||
        state is StudentListLoading ||
        state is StudentMultipleSelectList ||
        state is MultipleDeleteConfirmation) {
      return Expanded(
        child: Container(
          child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: <Widget>[
                  _createStateListTiles(state),
                  _deleteConfirmation(state)
                ],
              )),
        ),
      );
    }

    return Container();
  }

  Widget _createStateListTiles(StudentListState state) {
    List<Student> list;
    if (state is StudentListLoading) {
      list = state.students;
    } else if (state is StudentListLoaded) {
      list = state.students;
    } else if (state is StudentMultipleSelectList) {
      list = state.students;
    } else if (state is MultipleDeleteConfirmation) {
      list = state.students;
    }
    if (list.length > 0) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          Student student = list[index];
          return StudentListTile(
            student: student,
            key: Key(student.id),
          );
        },
      );
    }
    return Container(
      child: Center(
        child: Text("No Students to display"),
      ),
    );
  }

  Future<Null> _loadStudentList() async {
    _studentListBloc.dispatch(ShowLoadedStudents());
  }

  Widget _deleteConfirmation(StudentListState state) {
    if (state is MultipleDeleteConfirmation) {
      String studentCount = state.selectedStudents.length.toString();
      return Container(
        child: AlertDialog(
          title: Text('Delete Multiple'),
          content: Text('$studentCount students selected for delete'),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _studentListBloc
                    .dispatch(DeleteMultipleConfirmationButtonPressed());
              },
            ),
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                _studentListBloc.dispatch(CancelDeleteMultipleConfirmation());
              },
            )
          ],
        ),
      );
    }
    return Container();
  }
}
