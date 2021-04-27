import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tution_app/models/teacher.dart';

abstract class TeacherEvent extends Equatable {
  TeacherEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends TeacherEvent{
  final id;
  final String name;
  final String telephone;

  SaveButtonPressed({
    this.id,
    @required this.name,
    @required this.telephone
  }) :super([name,telephone]);

  @override 
  String toString() => 'Teacher Save button pressed {name: $name, telephone:$telephone}';
}


class AddButtonPressed extends TeacherEvent{
  @override
  String toString() => 'Teacher Add button pressed';

}

class EditButtonPressed extends TeacherEvent {
  final Teacher teacher;
  EditButtonPressed(this.teacher):super([teacher]);

  @override
  String toString() => 'Teacher Edit button pressed';
}

class DeleteButtonPressed extends TeacherEvent {
  final Teacher teacher;
  DeleteButtonPressed(this.teacher):super([teacher]);

  @override
  String toString() => 'Teahcer Edit button pressed';
}


class DeleteConfirmationButtonPressed extends TeacherEvent{
  final Teacher teacher;

  DeleteConfirmationButtonPressed(this.teacher);

  @override
  String toString() => 'Teacher Delete Confirmation butoon pressed';
}

class CancelButtonPressed extends TeacherEvent {
    String toString() => 'Teacher Cancel button pressed'; 
}


class LoadTeachers extends TeacherEvent {

}

