import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/pages/drawer/subject_page_widgets/subject_add_tile.dart';
import 'package:tution_app/pages/drawer/subject_page_widgets/subject_tile.dart';
import 'package:tution_app/repository/subject_repository.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';

class SubjectPage extends StatefulWidget {

  final SubjectBloc subjectBloc;

  const SubjectPage({Key key,@required this.subjectBloc}) : super(key: key);
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  SubjectBloc _subjectBloc;

  @override
  void initState() {
    _subjectBloc = widget.subjectBloc;
    _subjectBloc.dispatch(LoadSubjects());
    super.initState();
  }

  @override
  void dispose() {
    _subjectBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubjectBloc>(
      bloc: _subjectBloc,
      child: Scaffold(
        appBar: _createAppBar(),
        body: BlocListener(
          bloc: _subjectBloc,
          listener: (BuildContext context, SubjectState state) {
            if (state is SubjectLoading) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Loading .."),
                      CircularProgressIndicator()
                    ],
                  ),
                ));
            }
            if (state is SubjectLoadingError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text("Load Failure"), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ));
            }
            if (state is SuccessfulSubmission) {
              _subjectBloc.dispatch(LoadSubjects());
            }
          },
          child: BlocBuilder(
            bloc: _subjectBloc,
            builder: (BuildContext context, SubjectState state) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: _createTileList(state),
                    ),
                  ),
                  _showDeleteDialog(state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _createTileList(SubjectState state) {
    List<Widget> list = new List();
    if (state is SubjectLoaded) {
      for (Subject subject in state.subjects) {
        list.add(SubjectTile(
          subject: subject,
          key: Key(subject.id),
        ));
      }
    }
    if (state is SubjectAdd) {
      list.add(SubjectAddTile());
      for (Subject subject in state.subjects) {
        list.add(SubjectTile(
          subject: subject,
          key: Key(subject.id),
        ));
      }
    }

    if (state is SubjectEdit) {
      for (Subject subject in state.subjects) {
        if (subject.id == state.id) {
          list.add(SubjectAddTile(
            subject: subject,
            key: Key(subject.id),
          ));
        } else {
          list.add(SubjectTile(
            subject: subject,
            key: Key(subject.id),
          ));
        }
      }
    }

    if (state is DeleteConfirmation) {
      for (Subject subject in state.subjects) {
        list.add(SubjectTile(
          subject: subject,
          key: Key(subject.id),
        ));
      }
    }
    return list;
  }

  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "Subjects",
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
            _subjectBloc.dispatch(AddButtonPressed());
          },
        )
      ],
    );
  }

  Widget _showDeleteDialog(SubjectState state) {
    if (state is DeleteConfirmation) {
      return AlertDialog(
        title: new Text("Delete ${state.subject.name}"),
        content: new Text("Press confirm to delete the subject"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              _subjectBloc.dispatch(CancelButtonPressed());
            },
          ),
          new FlatButton(
            child: new Text(
              "Confirm",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              _subjectBloc
                  .dispatch(DeleteConfirmationButtonPressed(state.subject));
            },
          ),
        ],
      );
    }
    return Container();
  }
}
