import 'package:equatable/equatable.dart';
import 'package:tution_app/models/institute.dart';

abstract class InstituteState extends Equatable {
  InstituteState([List props = const []]) : super(props);
}

class InstituteEdit extends InstituteState {
  final List<Institute> institutes;
  final String id;  

  InstituteEdit([this.institutes = const [],this.id]) : super([institutes,id]);

  @override
  String toString() {
    return 'InstituteEdit';
  }
}

class InstituteAdd extends InstituteState {
  final List<Institute> institutes;

  InstituteAdd([this.institutes = const []]) : super([institutes]);

  @override
  String toString() {
    return 'InstituteAdd';
  }
}

class InstituteLoaded extends InstituteState {
  final List<Institute> institutes;

  InstituteLoaded([this.institutes = const []]) : super([institutes]);

  @override
  String toString() {
    return 'InstituteLoaded';
  }
}

class InstituteLoading extends InstituteState {
  @override
  String toString() {
    return 'InstituteLoading';
  }
}

class InstituteLoadingError extends InstituteState {
  @override
  String toString() {
    return 'InstituteNotLoaded';
  }
}


class SuccessfulSubmission extends InstituteState{
  @override
  String toString() {
  return "Successfuly submitted";
   }
}

class DeleteConfirmation extends InstituteState{
  final Institute institute;
  final List<Institute> institutes;

  DeleteConfirmation(this.institutes, [this.institute]):super([institutes,institute]);

  @override
  String toString(){
    return 'InstituteDeleteConfirmation';
  }
}
