import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/subject.dart';

abstract class SubjectEvent extends Equatable{
  SubjectEvent([List props =const []]) :super(props);
}

class SaveButtonPressed extends SubjectEvent {
  final id;
  final String name;

  SaveButtonPressed(
    {this.id,@required this.name}
    ):super([name]);

  @override
  String toString() {
    return 'Subject Save button pressed {name: $name}';
  }

}


class AddButtonPressed extends SubjectEvent{
  @override
  String toString() => 'Subject Add button pressed';

}

class EditButtonPressed extends SubjectEvent {
  final Subject subject;
  EditButtonPressed(this.subject):super([subject]);

  @override
  String toString() => 'Subject Edit button pressed';
}

class DeleteButtonPressed extends SubjectEvent {
  final Subject subject;
  DeleteButtonPressed(this.subject):super([subject]);

  @override
  String toString() => 'Subject Edit button pressed';
}


class DeleteConfirmationButtonPressed extends SubjectEvent{
  final Subject subject;

  DeleteConfirmationButtonPressed(this.subject);

  @override
  String toString() => 'Subject Delete Confirmation butoon pressed';
}

class CancelButtonPressed extends SubjectEvent {
    String toString() => 'Subject Cancel button pressed'; 
}


class LoadSubjects extends SubjectEvent {

}
