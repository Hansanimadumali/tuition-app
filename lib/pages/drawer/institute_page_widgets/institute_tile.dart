import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/institute.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';

class InstituteTile extends StatefulWidget {
  final Institute institute;

  const InstituteTile({Key key, this.institute}) : super(key: key);
  @override
  _InstituteTileState createState() => _InstituteTileState();
}

class _InstituteTileState extends State<InstituteTile> {

   final GlobalKey _keyRed = GlobalKey();
  InstituteBloc get _subjectBloc => BlocProvider.of<InstituteBloc>(context);

  @override
  Widget build(BuildContext context) {
     return ListTile(
          trailing: PopupMenuButton(
        key: _keyRed,
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Text("Edit"),
              value: EditButtonPressed(widget.institute),
            ),
            PopupMenuItem(
              child: Text('Delete'),
              value: DeleteButtonPressed(widget.institute),
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
        child: Center(
          child: Icon(Icons.school)
        ),
      ),
      title: Text(widget.institute.name,
          style: TextStyle(fontSize: 16.0, color: Color(0xff142d4c))),
      subtitle: Text(widget.institute.location),
    );
  }
}