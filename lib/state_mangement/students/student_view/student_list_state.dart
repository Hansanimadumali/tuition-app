import 'package:equatable/equatable.dart';
import 'package:tution_app/models/student.dart';

abstract class StudentListState extends Equatable {
  StudentListState([List props = const []]):super(props);
}

class StudentListLoading extends StudentListState{
  final List<Student> students;

  StudentListLoading(this.students) :super([students]);

  @override
  String toString() {
    return 'StudentList Loading';
  }
}

class StudentListLoaded extends StudentListState{
  final List<Student> students;

  StudentListLoaded(this.students):super([students]);
  @override
  String toString() {
  return 'StudentList Loaded';
   }
}

class StudentListLoadingError extends StudentListState{
  @override
  String toString() {
  return 'StudentList Loading Error';
   }
}

class LoadingToAddScreen extends StudentListState {
  final List<Student> students;

  LoadingToAddScreen(this.students) :super([students]);

  @override
  String toString() {
    return 'Loading to Add Screen';
  }
}

class StudentMultipleSelectList extends StudentListState {
  final List<Student> students;
  final List<Student> selectedStudents;

  StudentMultipleSelectList(this.students, this.selectedStudents)
      :super([students, selectedStudents]);

  @override
  String toString() {
    return 'Student select window';
  }
}

class MultipleDeleteConfirmation extends StudentListState{
  final List<Student> students;
  final List<Student> selectedStudents;

  MultipleDeleteConfirmation(this.students, this.selectedStudents):super([students,selectedStudents]);

  @override
  String toString() {
    return 'Delete multiple dialog window';
  }
}

class SuccessfulSubmission extends StudentListState {
  final List<Student> students;

  SuccessfulSubmission(this.students) :super([students]);

  @override
  String toString() {
    return 'Successfully submitted';
  }

}