import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tution_app/models/institute.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/models/teacher.dart';
import 'package:tution_app/models/tution_class.dart';
import 'package:tution_app/repository/class_repository.dart';
import 'package:tution_app/state_mangement/classes/class_list/class_list_bloc_sm.dart';
import 'package:tution_app/state_mangement/classes/classes_crud/classes_crud_sm.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_page_sm.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_page_sm.dart';

class ClassAdd extends StatefulWidget {
  final TeacherBloc teacherBloc;
  final SubjectBloc subjectBloc;
  final InstituteBloc instituteBloc;
  final ClassListBloc classListBloc;
  final TutionClass tutionClass;

  const ClassAdd(
      {Key key,
      this.teacherBloc,
      this.subjectBloc,
      this.instituteBloc,
      this.tutionClass,
      this.classListBloc})
      : super(key: key);

  @override
  _ClassAddState createState() => _ClassAddState();
}

class _ClassAddState extends State<ClassAdd> {
  ClassCrudBloc _classCrudBloc;
  String _className = "";

  int _grade;
  List<int> _gradeList;

  String _institute;
  List<Institute> _instituteList = [];

  String _medium;
  List<String> _mediumList = ["Sinhala", "Tamil", "English"];

  String _teacher;
  List<Teacher> _teacherList = [];

  String _subject;
  List<Subject> _subjectList = [];

  DateTime _endClassDate = DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  String id;
  TextEditingController _classNameEditingController = TextEditingController();
  TextEditingController _classFeeEditingController = TextEditingController();
  TextEditingController _instituteFeeEditingController =
      TextEditingController();

  bool get _isPopulated =>
      _classFeeEditingController.text.isNotEmpty &&
      _classNameEditingController.text.isNotEmpty &&
      _instituteFeeEditingController.text.isNotEmpty &&
      _subject != null &&
      _teacher != null &&
      _institute != null;

  bool isSubmitButtonEnabled(ClassAddState state) {
    return _isPopulated && state.isFormValid && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    if (widget.instituteBloc.currentState is InstituteLoaded) {
      _instituteList =
          (widget.instituteBloc.currentState as InstituteLoaded).institutes;
    }
    if (widget.subjectBloc.currentState is SubjectLoaded) {
      _subjectList =
          (widget.subjectBloc.currentState as SubjectLoaded).subjects;
    }
    if (widget.teacherBloc.currentState is TeacherLoaded) {
      _teacherList =
          (widget.teacherBloc.currentState as TeacherLoaded).teachers;
    }

    _grade = 6;
    _gradeList = [6, 7, 8, 9, 10, 11, 12, 13];
    _classCrudBloc = ClassCrudBloc(classRepository: ClassRepository());

    _classFeeEditingController.addListener(_onClassFeeChanged);
    _classNameEditingController.addListener(_onClassNameChanged);
    _instituteFeeEditingController.addListener(_onInstituteFeeChanged);

    _initializeDataForEdit();
  }

  void _initializeDataForEdit() {
    if (widget.tutionClass != null) {
      this.id = widget.tutionClass.id;
      this._grade = widget.tutionClass.grade;
      this._medium = widget.tutionClass.medium;
      this._endClassDate = DateTime.parse(widget.tutionClass.endDate);
      this._institute = widget.tutionClass.institute.id;
      this._subject = widget.tutionClass.subject.id;
      this._teacher = widget.tutionClass.teacher.id;
      this._className = widget.tutionClass.className;
      this._classNameEditingController.text = this._className;
      this._classFeeEditingController.text =
          widget.tutionClass.classFee.toString();
      this._instituteFeeEditingController.text =
          widget.tutionClass.institute.toString();
    }
  }

  @override
  void dispose() {
    _classFeeEditingController.dispose();
    _classNameEditingController.dispose();
    _instituteFeeEditingController.dispose();
    _classCrudBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener(
        bloc: _classCrudBloc,
        listener: (BuildContext context, ClassAddState state) {
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
            widget.classListBloc.dispatch(LoadClassList());
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
            bloc: _classCrudBloc,
            builder: (BuildContext context, ClassAddState state) {
              return _buildBody(state);
            }),
      ),
    );
  }

  Container _buildBody(ClassAddState state) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(_className == "" ? "Class X" : _className,
                        style: TextStyle(
                            fontSize: 25.0, color: Color(0xff385170))),
                  ),
                  _classNameInputField(state),
                  _classGradeInputField(),
                  _classInstituteInputField(),
                  _classTeacherInputField(),
                  _classSubjectInputField(),
                  _classMediumSelect(),
                  _classFeeInputField(state),
                  _instituteFeeInputField(state),
                  _classEndingDate(),
//                    _saveButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "add a class",
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      iconTheme: new IconThemeData(color: Colors.black),
      actions: <Widget>[
        Container(
          child: BlocBuilder(
              bloc: _classCrudBloc,
              builder: (BuildContext context, ClassAddState state) {
                return Container(
                  child: FlatButton(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: isSubmitButtonEnabled(state)
                              ? Colors.blue
                              : Colors.grey,
                          fontSize: 18.0),
                    ),
                    onPressed: () {
                      if (isSubmitButtonEnabled(state)) {
                        _onDataSaved();
                      }
                    },
                  ),
                );
              }),
        )
      ],
    );
  }

  Container _saveButton() {
    return Container(
      height: 30.0,
      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
      decoration: BoxDecoration(
          color: Color(0xff142d4c), borderRadius: BorderRadius.circular(15.0)),
      child: Center(
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Future<Null> _selectClassDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _endClassDate,
      firstDate: new DateTime(DateTime.now().year),
      lastDate: new DateTime(DateTime.now().year + 3),
    );

    if (picked != null && picked != _endClassDate) {
      setState(() {
        _endClassDate = picked;
      });
    }
  }

  Container _classEndingDate() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0,bottom: 40.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.event_available,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              "Ending Date",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 24.0,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _selectClassDate(context);
            },
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: Text(
                formatter.format(_endClassDate),
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _classSubjectInputField() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.subject,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              "Subject",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 24.0,
          ),
          DropdownButton<String>(
            hint: new Text("Select Subject"),
            value: _subject,
            onChanged: (String newValue) {
              setState(() {
                _subject = newValue;
              });
            },
            items: _subjectList.map((Subject value) {
              return new DropdownMenuItem<String>(
                value: value.id,
                child: Center(child: new Text(value.name)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Container _classTeacherInputField() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.school,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              "Teacher",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 24.0,
          ),
          DropdownButton<String>(
            hint: new Text("Select Teacher"),
            value: _teacher,
            onChanged: (String newValue) {
              setState(() {
                _teacher = newValue;
              });
            },
            items: _teacherList.map((Teacher value) {
              return new DropdownMenuItem<String>(
                value: value.id,
                child: Center(child: new Text(value.name)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Container _classInstituteInputField() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.school,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              "Institute",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 24.0,
          ),
          DropdownButton<String>(
            hint: new Text("Select Institute"),
            value: _institute,
            onChanged: (String newValue) {
              setState(() {
                _institute = newValue;
              });
            },
            items: _instituteList.map((Institute value) {
              return new DropdownMenuItem<String>(
                value: value.id,
                child: Center(child: new Text(value.name)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Container _classMediumSelect() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.language,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              "Medium",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 24.0,
          ),
          DropdownButton<String>(
            hint: new Text("Select Medium"),
            value: _medium,
            onChanged: (String newValue) {
              setState(() {
                _medium = newValue;
              });
            },
            items: _mediumList.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: Center(child: new Text(value.toString())),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Container _classGradeInputField() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.grade,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            child: Text(
              "Grade",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: 24.0,
          ),
          DropdownButton<int>(
            hint: new Text("Select Grade"),
            value: _grade,
            onChanged: (int newValue) {
              setState(() {
                _grade = newValue;
              });
            },
            items: _gradeList.map((int value) {
              return new DropdownMenuItem<int>(
                value: value,
                child: Center(child: new Text(value.toString())),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  TextFormField _classNameInputField(ClassAddState state) {
    return TextFormField(
      controller: _classNameEditingController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      autovalidate: true,
      autofocus: false,
      autocorrect: false,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.event,
          size: 18.0,
        ),
        hintText: 'What is the name of the class?',
        labelText: 'Class name',
      ),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (value) =>
          !state.isClassNameValid ? 'Invalid Class Name' : null,
    );
  }

  TextFormField _classFeeInputField(ClassAddState state) {
    return TextFormField(
      controller: _classFeeEditingController,
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: false),
      maxLines: 1,
      autofocus: false,
      autocorrect: false,
      autovalidate: true,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.monetization_on,
          size: 18.0,
        ),
        hintText: 'What is the class fee?',
        labelText: 'Class fee',
      ),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (value) => !state.isClassFeeValid ? 'Invalid Class Fee' : null,
    );
  }

  TextFormField _instituteFeeInputField(ClassAddState state) {
    return TextFormField(
      controller: _instituteFeeEditingController,
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: false),
      maxLines: 1,
      autofocus: false,
      autocorrect: false,
      autovalidate: true,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.monetization_on,
          size: 18.0,
        ),
        hintText: 'Institute fee for a student?',
        labelText: 'Institute fee',
      ),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (value) =>
          !state.isInstituteFeeValid ? 'Invalid Institute Fee' : null,
    );
  }

  void _onClassNameChanged() {
    setState(() {
      _className = _classNameEditingController.text;
    });
    _classCrudBloc.dispatch(
        ClassNameChanged(className: _classNameEditingController.text));
  }

  void _onClassFeeChanged() {
    _classCrudBloc.dispatch(ClassFeeChanged(
        classFee: double.parse(_classFeeEditingController.text),
        insituteFee: double.parse(_instituteFeeEditingController.text)));
  }

  void _onInstituteFeeChanged() {
    _classCrudBloc.dispatch(InstituteFeeChanged(
        instituteFee: double.parse(_instituteFeeEditingController.text),
        classFee: double.parse(_classFeeEditingController.text)));
  }

  void _onDataSaved() {
    TutionClass tutionClass = new TutionClass(
        id: id,
        className: _className,
        classFee: double.parse(_classFeeEditingController.text),
        instituteFee: double.parse(_instituteFeeEditingController.text),
        endDate: formatter.format(_endClassDate),
        teacher: _getTeacher(),
        subject: _getSubject(),
        institute: _getInstitute(),
        grade: _grade,
        medium: _medium);

    _classCrudBloc.dispatch(ClassSaveButtonPressed(tutionClass: tutionClass));
  }

  Teacher _getTeacher() {
    for (Teacher teacher in this._teacherList) {
      if (teacher.id == _teacher) {
        return teacher;
      }
    }
  }

  Subject _getSubject() {
    for (Subject subject in _subjectList) {
      if (subject.id == _subject) {
        return subject;
      }
    }
  }

  Institute _getInstitute() {
    for (Institute institute in _instituteList) {
      if (institute.id == _institute) {
        return institute;
      }
    }
  }
}
