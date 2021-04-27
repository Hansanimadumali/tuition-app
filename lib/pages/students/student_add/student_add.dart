import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/student_add/app_bar_student_add.dart';
import 'package:tution_app/pages/students/student_add/photo_insert.dart';
import 'package:tution_app/repository/student_repository.dart';
import 'package:tution_app/state_mangement/students/student_crud/student_crud_sm.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';

class StudentAdd extends StatefulWidget {
  final Student student;
  final StudentListBloc studentListBloc;

  const StudentAdd({Key key, this.student, this.studentListBloc})
      : super(key: key);

  @override
  _StudentAddState createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  StudentCrudBloc _studentCrudBloc;
  final List<String> _parentTypes = ["Mother", "Father", "Other"];

  String id;
  int _grade;
  File _profilePhoto;
  String _parent = "Mother";
  List<int> _gradesList;
  bool _isPopulated = false;
  TextEditingController _firstNameTextEditingController =
  TextEditingController();
  TextEditingController _lastNameTextEditingController =
  TextEditingController();
  TextEditingController _schoolTextEditingController = TextEditingController();
  TextEditingController _mobileTextEditingController = TextEditingController();
  TextEditingController _parentMobileTextEditingController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _grade = 6;
    _gradesList = [6, 7, 8, 9, 10, 11, 12, 13];
    _parent = null;
    _studentCrudBloc = StudentCrudBloc(studentRepository: StudentRepository());
    _firstNameTextEditingController.addListener(_onFirstNameChanged);
    _lastNameTextEditingController.addListener(_onLastNameChanged);
    _mobileTextEditingController.addListener(_onMobileNumberChanged);
    _parentMobileTextEditingController
        .addListener(_onParentMobileNumberChanged);
    _schoolTextEditingController.addListener(_onSchoolChanged);

    _initializeDataForEdit();
  }

  void _initializeDataForEdit() {
    if (widget.student != null) {
      this.id = widget.student.id;
      this._grade = widget.student.grade;
      this._parent = widget.student.parentType;
      this._firstNameTextEditingController.text = widget.student.firstName;
      this._lastNameTextEditingController.text = widget.student.lastName;
      this._schoolTextEditingController.text = widget.student.school;
      this._parentMobileTextEditingController.text =
          widget.student.parentMobile;
      this._mobileTextEditingController.text = widget.student.mobile;
      _onFirstNameChanged();
      _onLastNameChanged();
      _onSchoolChanged();
      _onParentMobileNumberChanged();
      _onMobileNumberChanged();
      _onParentTypeChanged();
    }
  }

  @override
  void dispose() {
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _mobileTextEditingController.dispose();
    _parentMobileTextEditingController.dispose();
    _schoolTextEditingController.dispose();
    _studentCrudBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStudentAdd(
        studentCrudBloc: _studentCrudBloc,
        isPopulated: _isPopulated,
        onDataSaved: _onDataSaved,
      ),
      body: BlocListener(
        bloc: _studentCrudBloc,
        listener: (BuildContext context, StudentAddState state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Failed to Submit"),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ));
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Submitting .."),
                    CircularProgressIndicator(),
                  ],
                ),
              ));
          }
          if (state.isSuccess) {
            widget.studentListBloc.dispatch(LoadStudentList());
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
          bloc: _studentCrudBloc,
          builder: (BuildContext context, StudentAddState state) {
            return _showBody(state);
          },
        ),
      ),
    );
  }

  Widget _showBody(StudentAddState state) {
    return Form(
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      PhotoInsert(
                        profilePhoto: _profilePhoto,
                        onChange: _updateImage,
                      ),
                      _showFirstNameInput(state),
                      _showLastNameInput(state),
                      _showSchoolInput(state),
                      _selectGradeInput(),
                      _showMobileNumber(state),
                      _addParent(state),
                    ]),
                  )),
            ],
          ),
          _createLoading(state)
        ],
      ),
    );
  }

  Widget _createLoading(StudentAddState state) {
    if (state.isSubmitting) {
      return Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container();
  }

  Widget _showFirstNameInput(StudentAddState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextFormField(
        controller: _firstNameTextEditingController,
        maxLines: 1,
        autofocus: false,
        autocorrect: false,
        autovalidate: true,
        decoration: new InputDecoration(
            hintText: 'First name',
            icon: new Icon(Icons.person, color: Colors.grey)),
        validator: (value) => !state.isFirstNameValid ? 'Invalid Name' : null,
      ),
    );
  }

  Widget _showLastNameInput(StudentAddState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextFormField(
        controller: _lastNameTextEditingController,
        maxLines: 1,
        autocorrect: false,
        autofocus: false,
        autovalidate: true,
        decoration: new InputDecoration(
            hintText: 'Last name',
            icon: new Icon(Icons.person, color: Colors.grey)),
        validator: (value) => !state.isLastNameValid ? 'Invalid Name' : null,
      ),
    );
  }

  Widget _showSchoolInput(StudentAddState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextFormField(
        controller: _schoolTextEditingController,
        maxLines: 1,
        autofocus: false,
        autocorrect: false,
        autovalidate: false,
        decoration: new InputDecoration(
            hintText: 'School',
            icon: new Icon(Icons.school, color: Colors.grey)),
      ),
    );
  }

  Widget _showMobileNumber(StudentAddState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextFormField(
        controller: _mobileTextEditingController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        autofocus: false,
        autocorrect: false,
        autovalidate: true,
        decoration: new InputDecoration(
            hintText: 'Telephone',
            icon: new Icon(Icons.call, color: Colors.grey)),
        validator: (value) =>
        !state.isTelephoneValid ? 'Invalid Phone Number' : null,
      ),
    );
  }

  Widget _selectGradeInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 125.0,
              child: Row(
                children: <Widget>[
                  new Icon(
                    Icons.grade,
                    color: Colors.grey,
                  ),
                  new SizedBox(
                    width: 15.0,
                  ),
                  new Text(
                    "Grade",
                    style: new TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            Container(
              width: 50.0,
              child: new DropdownButton<int>(
                value: _grade,
                onChanged: (int value) {
                  setState(() {
                    _grade = value;
//                    _onGradeChanged();
                  });
                },
                items: _gradesList.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }

  Widget _addParent(StudentAddState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                new Icon(
                  Icons.contacts,
                  color: Colors.grey,
                ),
                new SizedBox(
                  width: 15.0,
                ),
              ],
            ),
          ),
          Container(
            width: 100.0,
            child: new DropdownButton<String>(
                value: _parent,
                hint: Text('Parent Type'),
                onChanged: (String value) {
                  setState(() {
                    _parent = value;
                    _onParentTypeChanged();
                  });
                },
                items:
                _parentTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ),
          Expanded(
            child: new TextFormField(
              controller: _parentMobileTextEditingController,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              autofocus: false,
              autocorrect: false,
              autovalidate: true,
              decoration: new InputDecoration(
                  hintText: 'Telephone',
                  icon: new Icon(Icons.call, color: Colors.grey)),
              validator: (value) =>
              !state.isParentMobileValid ? 'Invalid Phone' : null,
            ),
          )
        ],
      ),
    );
  }

  void _isPopulatedCheck() {
    bool isPopulated = _firstNameTextEditingController.text.isNotEmpty &&
        _lastNameTextEditingController.text.isNotEmpty &&
        _mobileTextEditingController.text.isNotEmpty &&
        _parentMobileTextEditingController.text.isNotEmpty;
    setState(() {
      _isPopulated = isPopulated;
    });
  }

  void _onFirstNameChanged() {
    _studentCrudBloc.dispatch(
        FirstNameChanged(firstName: _firstNameTextEditingController.text));
    _isPopulatedCheck();
  }

  void _onLastNameChanged() {
    _studentCrudBloc.dispatch(
        LastNameChanged(lastName: _lastNameTextEditingController.text));
    _isPopulatedCheck();
  }

  void _onSchoolChanged() {
    _studentCrudBloc
        .dispatch(SchoolChanged(school: _schoolTextEditingController.text));
    _isPopulatedCheck();
  }

  void _onParentMobileNumberChanged() {
    _studentCrudBloc.dispatch(ParentMobileChanged(
        parentMobile: _parentMobileTextEditingController.text));
    _isPopulatedCheck();
  }

  void _onMobileNumberChanged() {
    _studentCrudBloc.dispatch(
        TelephoneChanged(telephone: _mobileTextEditingController.text));
    _isPopulatedCheck();
  }

  void _updateImage(File image) {
    setState(() {
      _profilePhoto = image;
    });
  }

  void _onDataSaved() {
    //     school: _schoolTextEditingController.text));
    Student student = new Student(
        id,
        _firstNameTextEditingController.text,
        _lastNameTextEditingController.text,
        _grade,
        _parent,
        _parentMobileTextEditingController.text,
        _mobileTextEditingController.text,
        _schoolTextEditingController.text,
        null,
        null);
    _studentCrudBloc.dispatch(SaveButtonPressed(
        student: student,
        imageFile: _profilePhoto != null ? _profilePhoto : null));
  }

  void _onParentTypeChanged() {
    _studentCrudBloc.dispatch(ParentTypeChanged(parentType: _parent));
    _isPopulatedCheck();
  }
}
