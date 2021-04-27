import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tution_app/models/institute.dart';

abstract class InstituteEvent extends Equatable {
  InstituteEvent([List props = const []]) : super(props);
}

class SaveButtonPressed extends InstituteEvent{
  final id;
  final String name;
  final String location;

  SaveButtonPressed({
    this.id,
    @required this.name,
    @required this.location
  }) :super([name,location]);

  @override 
  String toString() => 'Institute Save button pressed {name: $name, location:$location}';
}


class AddButtonPressed extends InstituteEvent{
  @override
  String toString() => 'Institute Add button pressed';

}

class EditButtonPressed extends InstituteEvent {
  final Institute institute;
  EditButtonPressed(this.institute):super([institute]);

  @override
  String toString() => 'Institute Edit button pressed';
}

class DeleteButtonPressed extends InstituteEvent {
  final Institute institute;
  DeleteButtonPressed(this.institute):super([institute]);

  @override
  String toString() => 'Teahcer Edit button pressed';
}


class DeleteConfirmationButtonPressed extends InstituteEvent{
  final Institute institute;

  DeleteConfirmationButtonPressed(this.institute);

  @override
  String toString() => 'Institute Delete Confirmation butoon pressed';
}

class CancelButtonPressed extends InstituteEvent {
    String toString() => 'Institute Cancel button pressed'; 
}


class LoadInstitutes extends InstituteEvent {

}

