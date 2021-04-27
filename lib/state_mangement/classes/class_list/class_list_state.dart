import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/tution_class.dart';

@immutable
abstract class ClassListState extends Equatable {
  ClassListState([List props = const []]) : super(props);
}

class ClassListLoading extends ClassListState {
  final List<TutionClass> classList;

  ClassListLoading({this.classList}):super([classList]);

  @override
  String toString() {
    return 'Loading class list';
  }
}


class ClassListLoaded extends ClassListState{
  final List<TutionClass> classList;

  ClassListLoaded({this.classList}):super([classList]);

  @override
  String toString() {
    return 'ClassListLoaded';
  }
}

class ClassListLoadingError extends ClassListState{
  @override
  String toString() {
    return 'ClassList Loading Error';
  }
}

class LoadingToAddScreen extends ClassListState{
  final List<TutionClass> classList;

  LoadingToAddScreen({this.classList}):super([classList]);

  @override
  String toString() {
    return 'Loading to Add Screen';
  }
}

class ClassMultipleSelectList extends ClassListState{
  final List<TutionClass> classList;
  final List<TutionClass> selectedClassList;

  ClassMultipleSelectList({this.classList, this.selectedClassList}):super([classList,selectedClassList]);

  @override
  String toString() {
    return 'StudentSelectWindow';
  }
}


class ClassSuccessfulSubmission extends ClassListState{
  final List<TutionClass> classList;

  ClassSuccessfulSubmission({this.classList}):super([classList]);

  @override
  String toString() {
    return 'Successfully submitted';
  }
}