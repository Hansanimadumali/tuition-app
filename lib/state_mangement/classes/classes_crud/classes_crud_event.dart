import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/tution_class.dart';

abstract class ClassAddEvent extends Equatable {
  ClassAddEvent([List props = const []]) : super(props);
}

class ClassNameChanged extends ClassAddEvent {
  final String className;

  ClassNameChanged({@required this.className}) : super([className]);

  @override
  String toString() {
    return 'ClassNameChanged: $className';
  }
}

class ClassGradeChanged extends ClassAddEvent {
  final int grade;

  ClassGradeChanged({@required this.grade}) : super([grade]);

  @override
  String toString() {
    return 'ClassClassChanged: $grade';
  }
}

class InstituteChanged extends ClassAddEvent {
  final String instituteId;

  InstituteChanged({@required this.instituteId}) : super([instituteId]);

  @override
  String toString() {
    return 'InstituteChanged: $instituteId';
  }
}

class ClassTeacherChanged extends ClassAddEvent {
  final String teacherId;

  ClassTeacherChanged({@required this.teacherId}) : super([teacherId]);

  @override
  String toString() {
    return 'ClassTeacherChanged: $teacherId';
  }
}

class ClassSubjectChanged extends ClassAddEvent {
  final String subjectId;

  ClassSubjectChanged({@required this.subjectId}) : super([subjectId]);

  @override
  String toString() {
    return 'ClassSubectChanged: $subjectId';
  }
}

class ClassFeeChanged extends ClassAddEvent {
  final double classFee;
  final double insituteFee;

  ClassFeeChanged({@required this.classFee,@required this.insituteFee}) : super([classFee]);

  @override
  String toString() {
    return 'ClassFeeChanged: $classFee';
  }
}

class InstituteFeeChanged extends ClassAddEvent {
  final double instituteFee;
  final double classFee;

  InstituteFeeChanged({@required this.instituteFee,this.classFee}) : super([instituteFee]);

  @override
  String toString() {
    return 'InstituteFeeChanged: $instituteFee';
  }
}

class ClassEndingDateChanged extends ClassAddEvent {
  final String endingDate;

  ClassEndingDateChanged({@required this.endingDate}) : super([endingDate]);

  @override
  String toString() {
    return 'ClassEndingDateChanged: $endingDate';
  }
}

class ClassSaveButtonPressed extends ClassAddEvent {
  final TutionClass tutionClass;

  ClassSaveButtonPressed({@required this.tutionClass}) : super([tutionClass]);

  @override
  String toString() {
    return 'SaveButtonPressed: $tutionClass';
  }
}
