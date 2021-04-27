import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/tution_class.dart';
import 'package:tution_app/pages/classes/main_profile/class_pages.dart';
import 'package:tution_app/state_mangement/classes/class_list/class_list_bloc_sm.dart';
import 'package:tution_app/state_mangement/classes/class_view/class_view_sm.dart';

class ClassListTile extends StatefulWidget {
  final TutionClass tutionClass;

  const ClassListTile({Key key, this.tutionClass}) : super(key: key);

  @override
  _ClassListTileState createState() => _ClassListTileState();
}

class _ClassListTileState extends State<ClassListTile> {
  TutionClass _tutionClass;

  ClassListBloc get _classListBloc => BlocProvider.of<ClassListBloc>(context);
  ClassViewBloc get _classViewBloc => BlocProvider.of<ClassViewBloc>(context);

  @override
  void initState() {
    super.initState();
    _tutionClass = widget.tutionClass;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _classListBloc,
      builder: (BuildContext context, ClassListState state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
            child: GestureDetector(
              onTap: () {
                if (state is ClassListLoaded) {
                  _classViewBloc.dispatch(LoadSingleClass(tutionClass: _tutionClass));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClassPages()));
                }
                if (state is ClassMultipleSelectList) {
                  _classListBloc.dispatch(
                      SelectMultipleClasses(tutionClass: _tutionClass));
                }
              },
              onLongPress: () {
                if (state is ClassListLoaded) {
                  _classListBloc.dispatch(
                      SelectMultipleClasses(tutionClass: _tutionClass));
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      _tutionClass.className,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                _buildMediumTag(state),
                              ],
                            )),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Grade " + _tutionClass.grade.toString(),
                                    style: TextStyle(color: Color(0xff385170)),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text("|"),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(_tutionClass.institute.name)
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                "By " + _tutionClass.teacher.name,
                                style: TextStyle(color: Color(0xff9fd3c7)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildMediumTag(ClassListState state) {
    if (state is ClassMultipleSelectList) {
      return Container(
        height: 30.0,
        child: Center(
            child: _checkSelected(state)
                ? Icon(
                    Icons.check_circle,
                    color: Color(0xff385170),
                  )
                : Icon(
                    Icons.check_circle_outline,
                    color: Color(0xff385170),
                  )),
      );
    }
    return Container(
      height: 30.0,
      child: Center(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              child: Container(
                  child: Text(
                _tutionClass.subject.name,
                style: TextStyle(fontSize: 11.0),
              )),
            ),
            Container(
              height: 28.0,
              width: 28.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: _getMediumColor(_tutionClass)),
              child: Center(
                child: Text(
                  _tutionClass.medium.toUpperCase()[0],
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Color(0xffececec), borderRadius: BorderRadius.circular(15.0)),
    );
  }

  Color _getMediumColor(TutionClass tutionClass) {
    if (tutionClass.medium.toLowerCase() == "sinhala") {
      return Color(0xff385170);
    } else if (tutionClass.medium.toLowerCase() == "english") {
      return Color(0xff9fd3c7);
    } else {
      return Colors.red;
    }
  }

  bool _checkSelected(ClassListState state) {
    if (state is ClassMultipleSelectList) {
      if (state.selectedClassList.contains(_tutionClass)) {
        return true;
      }
    }
    return false;
  }
}
