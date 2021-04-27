import 'package:equatable/equatable.dart';
import 'package:tution_app/models/subject.dart';

abstract class SubjectState extends Equatable{
  SubjectState([List props =const []]) :super(props);
}

class SubjectEdit extends SubjectState {
  final List<Subject> subjects;
  final String id;

  SubjectEdit(this.subjects,this.id):super([subjects,id]);

  @override
  String toString() {
    return 'SubjectEdit';
  }
  
}


class SubjectAdd extends SubjectState {
  final List<Subject> subjects;
  
  SubjectAdd(this.subjects):super([subjects]);

  @override
  String toString() {
    return 'SubjectAdd';
  }
}


class SubjectLoaded extends SubjectState{
    final List<Subject> subjects;
  
  SubjectLoaded(this.subjects):super([subjects]);

  @override
  String toString() {
    return 'SubjectLoaded';
  }
}

class SubjectLoading extends SubjectState{
  @override
  String toString() {
    return 'SubjectLoading';
  }
}

class SubjectLoadingError extends SubjectState {
  @override
  String toString() {
    return 'SubjectNotLoaded';
  }
}

class SuccessfulSubmission extends SubjectState{
  @override
  String toString() {
  return "Successfuly submitted";
   }
}

class DeleteConfirmation extends SubjectState {
  final Subject subject;
  final List<Subject> subjects;

  DeleteConfirmation(this.subject, this.subjects):super([subject,subjects]);

  @override
  String toString() {
    return 'SubjectDeleteConfirmation';
  }
}