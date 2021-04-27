import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/student.dart';

abstract class StudentListEvent extends Equatable {
  StudentListEvent([List props = const[]]):super(props);
}

class LoadStudentList extends StudentListEvent{
  @override
  String toString() {
  return 'LoadStudentList';
   }
}

class NavigateAddScreen extends StudentListEvent {
  @override
  String toString() {
    return 'NavigateToAddScreen';
  }
}

class SelectMultipleStudents extends StudentListEvent {
  final Student student;

  SelectMultipleStudents({@required this.student}) :super([student]);

  @override
  String toString() {
    return 'MultipleSelectLongPressed';
  }
}


class CancelSelectMultiple extends StudentListEvent {
  @override
  String toString() {
    return 'Cancel selected student list';
  }
}

class DeleteMultiple extends StudentListEvent {
  @override
  String toString() {
    return 'Delete Mutiple Button Pressed';
  }
}


class DeleteMultipleConfirmationButtonPressed extends StudentListEvent{
  @override
  String toString() {
    return 'Delete multiple students confirmation';
  }
}

class CancelDeleteMultipleConfirmation extends StudentListEvent{
  @override
  String toString() {
    return 'Cancel Delete Multiple confirmation';
  }
}

class ShowLoadedStudents extends StudentListEvent {
  @override
  String toString() {
    return 'Show loaded students';
  }
}