import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/institute.dart';
import 'package:tution_app/pages/drawer/institute_page_widgets/institute_add_tile.dart';
import 'package:tution_app/pages/drawer/institute_page_widgets/institute_tile.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';

class InstitutePage extends StatefulWidget {
  final InstituteBloc instituteBloc;

  const InstitutePage({Key key, @required this.instituteBloc})
      : super(key: key);

  @override
  _InstitutePageState createState() => _InstitutePageState();
}

class _InstitutePageState extends State<InstitutePage> {
  InstituteBloc _instituteBloc;

  @override
  void initState() {
    super.initState();
    _instituteBloc = widget.instituteBloc;
    _instituteBloc.dispatch(LoadInstitutes());
  }

  @override
  void dispose() {
    super.dispose();
    _instituteBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _instituteBloc,
      child: Scaffold(
        appBar: _createAppBar(),
        body: BlocListener(
          bloc: _instituteBloc,
          listener: (BuildContext context, InstituteState state) {
            if (state is InstituteLoading) {
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
            if (state is InstituteLoadingError) {
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
              _instituteBloc.dispatch(LoadInstitutes());
            }
          },
          child: BlocBuilder(
            bloc: _instituteBloc,
            builder: (BuildContext context, InstituteState state) {
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

  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "Institutes",
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
            _instituteBloc.dispatch(AddButtonPressed());
          },
        )
      ],
    );
  }

  Widget _showDeleteDialog(InstituteState state) {
    if (state is DeleteConfirmation) {
      return AlertDialog(
        title: new Text("Delete ${state.institute.name}"),
        content: new Text("Press confirm to delete the institute"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              _instituteBloc.dispatch(CancelButtonPressed());
            },
          ),
          new FlatButton(
            child: new Text(
              "Confirm",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              _instituteBloc
                  .dispatch(DeleteConfirmationButtonPressed(state.institute));
            },
          ),
        ],
      );
    }
    return Container();
  }

  List<Widget> _createTileList(InstituteState state) {
    List<Widget> list = new List();
    if (state is InstituteLoaded) {
      for (Institute institute in state.institutes) {
        list.add(InstituteTile(
          institute: institute,
          key: Key(institute.id),
        ));
      }
    }

    if (state is InstituteAdd) {
      list.add(InstituteAddTile());
      for (Institute institute in state.institutes) {
        list.add(InstituteTile(
          institute: institute,
          key: Key(institute.id),
        ));
      }
    }

    if (state is InstituteEdit) {
      for (Institute institute in state.institutes) {
        if (institute.id == state.id) {
          list.add(InstituteAddTile(
            institute: institute,
            key: Key(institute.id),
          ));
        }
      }
    }

    if (state is DeleteConfirmation) {
      for (Institute institute in state.institutes) {
        list.add(InstituteTile(
          institute: institute,
          key: Key(institute.id),
        ));
      }
    }

    return list;
  }
}
