import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';

class SubjectTile extends StatefulWidget {
  final Subject subject;

  const SubjectTile({Key key, this.subject}) : super(key: key);

  @override
  _SubjectTileState createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  final GlobalKey _keyRed = GlobalKey();
  SubjectBloc get _subjectBloc => BlocProvider.of<SubjectBloc>(context);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: PopupMenuButton(
        key: _keyRed,
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Text("Edit"),
              value: EditButtonPressed(widget.subject),
            ),
            PopupMenuItem(
              child: Text('Delete'),
              value: DeleteButtonPressed(widget.subject),
            )
          ];
        },
        onSelected: (event) => _subjectBloc.dispatch(event),
      ),
      onLongPress: () {
        dynamic popUpMenuState = _keyRed.currentState;
        popUpMenuState.showButtonMenu();
      },
      leading: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(child: Icon(Icons.subject)),
      ),
      title: Text(this.widget.subject.name,
          style: TextStyle(fontSize: 16.0, color: Color(0xff142d4c))),
    );
  }
}
