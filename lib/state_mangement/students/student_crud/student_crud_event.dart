import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/student.dart';

abstract class StudentAddEvent extends Equatable {
  StudentAddEvent([List props = const []]) : super(props);
}


class FirstNameChanged extends StudentAddEvent {
  final String firstName;

  FirstNameChanged({@required this.firstName}) : super([firstName]);

  @override
  String toString() {
    return 'FirstNameChanged: $firstName';
  }
}

class LastNameChanged extends StudentAddEvent {
  final String lastName;

  LastNameChanged({@required this.lastName}) : super([lastName]);

  @override
  String toString() {
    return 'LastNameChanged: $lastName';
  }
}

class SchoolChanged extends StudentAddEvent {
  final String school;

  SchoolChanged({@required this.school}) : super([school]);

  @override
  String toString() {
    return 'SchoolChanged: $school';
  }
}

class SaveButtonPressed extends StudentAddEvent {
  final Student student;
  final File imageFile;

  SaveButtonPressed({@required this.student, this.imageFile,})
      : super([student]);

  @override
  String toString() {
    return 'Student: $student';
  }
}

class TelephoneChanged extends StudentAddEvent {
  final String telephone;

  TelephoneChanged({@required this.telephone}) : super([telephone]);

  @override
  String toString() {
    return 'TelephoneChanged: $telephone';
  }
}

class ParentTypeChanged extends StudentAddEvent {
  final String parentType;

  ParentTypeChanged({@required this.parentType}) : super([parentType]);

  @override
  String toString() {
    return 'ParentTypeChanged: $parentType';
  }
}

class ParentMobileChanged extends StudentAddEvent {
  final String parentMobile;

  ParentMobileChanged({@required this.parentMobile}) : super([parentMobile]);

  @override
  String toString() {
    return 'ParentMobileChanged: $parentMobile';
  }
}

class UpdateStudentList extends StudentAddEvent {
  @override
  String toString() {
    return 'Load Student List from Student add';
  }
}

