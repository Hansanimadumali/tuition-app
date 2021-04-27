import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';

class SubjectAddTile extends StatefulWidget {
  final Subject subject;

  const SubjectAddTile({Key key, this.subject}) : super(key: key);

  @override
  _SubjectAddTileState createState() => _SubjectAddTileState();
}

class _SubjectAddTileState extends State<SubjectAddTile> {
  final _subjectNameController = TextEditingController();
  SubjectBloc get _subjectBloc => BlocProvider.of<SubjectBloc>(context);
  Subject _subject;

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      _subject = widget.subject;
      _subjectNameController.text = _subject.name;
    }
  }

  @override
  void dispose() {
    _subjectBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 60.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffececec)),
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 25.0,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    _subjectNameInput(),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.save,
                      color: Colors.blue,
                      size: 17.0,
                    ),
                    onPressed: () {
                      _subjectBloc.dispatch(SaveButtonPressed(
                          id: _subject != null ? _subject.id : null,
                          name: _subjectNameController.text));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 17.0,
                    ),
                    onPressed: () {
                      _subjectBloc.dispatch(CancelButtonPressed());
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField _subjectNameInput() {
    return TextFormField(
      controller: _subjectNameController,
      decoration: const InputDecoration(
          hintText: 'Subject name',
          labelText: 'Subject',
          contentPadding: EdgeInsets.symmetric(vertical: 5.0)),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    );
  }
}
