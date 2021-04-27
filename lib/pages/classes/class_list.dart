import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/tution_class.dart';
import 'package:tution_app/pages/classes/custom_widgets/class_list_tile.dart';
import 'package:tution_app/pages/classes/custom_widgets/tutuion_class_bottomsheet_filter.dart';
import 'package:tution_app/pages/classes/main_profile/class_add.dart';
import 'package:tution_app/state_mangement/classes/class_list/class_list_bloc_sm.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';

class ClassList extends StatefulWidget {
  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  List<TutionClass> _list = new List();

  List<TutionClass> _searchedList = new List();
  String _searchText = "";
  bool _isSearching = false;
  String _searchSubject = "";
  String _searchTeacher = "";
  String _searchInstitute = "";
  int _searchGrade = -1;
  final TextEditingController _controller = new TextEditingController();

  ClassListBloc get _classListBloc => BlocProvider.of<ClassListBloc>(context);

  TeacherBloc get _teacherBloc => BlocProvider.of<TeacherBloc>(context);

  InstituteBloc get _instituteBloc => BlocProvider.of<InstituteBloc>(context);

  SubjectBloc get _subjectBloc => BlocProvider.of<SubjectBloc>(context);

  _ClassListState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
//    _classListBloc.dispatch(LoadClassList());
  }

  void _searchOperation(String searchText) {
    if (_isSearching != null || _isSearching == false) {
      _searchedList.clear();
      _handleStartSearch();
      bool _isSubstring;
      bool _isMatchGrade;
      bool _isInstituteMatch;
      bool _isTeacherMatch;
      bool _isSubjectMatch;
      for (int i = 0; i < _list.length; i++) {
        TutionClass data = _list[i];
        _isSubstring = false;
        _isMatchGrade = false;
        _isInstituteMatch = false;
        _isTeacherMatch = false;
        _isSubjectMatch = false;

        String text = data.toString();
        if (text.toLowerCase().contains(searchText.toLowerCase())) {
          _isSubstring = true;
        }

        if (_searchGrade == -1) {
          _isMatchGrade = true;
        } else if (_searchGrade == data.grade) {
          _isMatchGrade = true;
        }

        if (_searchInstitute == "" || _searchInstitute == data.institute) {
          _isInstituteMatch = true;
        }

        if (_searchSubject == "" || _searchSubject == data.subject) {
          _isSubjectMatch = true;
        }

        if (_searchTeacher == "" || _searchTeacher == data.teacher) {
          _isTeacherMatch = true;
        }

        if (_isMatchGrade &&
            _isSubstring &&
            _isInstituteMatch &&
            _isTeacherMatch &&
            _isSubjectMatch) {
          _searchedList.add(data);
        }
      }
      _handleSearchEnd();
    }
  }

  bool _shouldFilter() {
    if (_searchedList.length != 0 ||
        _searchGrade != -1 ||
        _searchInstitute != "" ||
        _searchSubject != "" ||
        _searchTeacher != "") {
      return true;
    }
    return false;
  }

  void _handleStartSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _classListBloc,
        listener: (BuildContext context, ClassListState state) {
          if (state is ClassListLoading) {
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
          if (state is ClassListLoadingError) {
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
          if (state is LoadingToAddScreen) {
            _loadClassList();
            _navigateToAddPage(context);
          }
          if (state is ClassSuccessfulSubmission) {
            _classListBloc.dispatch(LoadClassList());
          }
        },
        child: BlocBuilder(
          bloc: _classListBloc,
          builder: (BuildContext context, ClassListState state) {
            return Container(
              child: Column(
                children: <Widget>[
                  _createSearchBar(context),
                  _createClassList(context, state)
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Future<Null> _loadClassList() async {
    _classListBloc.dispatch(LoadClassList());
  }

  Future<Null> _onRefresh() async {
    _classListBloc.dispatch(LoadClassList());
  }

  Future<Null> _navigateToAddPage(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassAdd(
                  subjectBloc: _subjectBloc,
                  teacherBloc: _teacherBloc,
                  instituteBloc: _instituteBloc,
                  classListBloc: _classListBloc,
                )));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocBuilder(
        bloc: _classListBloc,
        builder: (BuildContext context, ClassListState state) {
          if (state is ClassMultipleSelectList) {
            return FloatingActionButton(
              onPressed: () {
                _classListBloc.dispatch(CancelSelectMultiple());
              },
              tooltip: 'Cancel Selected',
              child: Icon(
                Icons.clear,
                size: 30.0,
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
            );
          }

          return FloatingActionButton(
            onPressed: () {
              _classListBloc.dispatch(NavigateAddScreen());
            },
            tooltip: 'Add Class',
            child: Icon(Icons.add),
          );
        });
  }

  Expanded _createClassList(BuildContext context, ClassListState state) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 0.0),
            child: Container(child: _createClassListTiles(state))));
  }

  Widget _createClassListTiles(ClassListState state) {
    List<TutionClass> list;
    if (state is ClassListLoading) {
      list = state.classList;
    } else if (state is ClassListLoaded) {
      list = state.classList;
    } else if (state is ClassMultipleSelectList) {
      list = state.classList;
    }

    if (list.length > 0) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          TutionClass tutionClass = list[index];
          return ClassListTile(
            key: Key(tutionClass.id),
            tutionClass: tutionClass,
          );
        },
      );
    }
  }

  Widget _createSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 0.0),
      child: Container(
        child: Card(
          elevation: 5.0,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                child: TextField(
                  onChanged: _searchOperation,
                  decoration: InputDecoration(
                      hintText: "Search Classes",
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.tune),
                        onPressed: () {
                          _filterModalBottomSheet(context);
                        },
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _filterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return TutionClassBottomsheetFilter();
        });
  }
}
