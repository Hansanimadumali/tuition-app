import 'package:equatable/equatable.dart';
import 'package:tution_app/models/teacher.dart';

abstract class TeacherState extends Equatable {
  TeacherState([List props = const []]) : super(props);
}

class TeacherEdit extends TeacherState {
  final List<Teacher> teachers;
  final String id;  

  TeacherEdit([this.teachers = const [],this.id]) : super([teachers,id]);

  @override
  String toString() {
    return 'TeacherEdit';
  }
}

class TeacherAdd extends TeacherState {
  final List<Teacher> teachers;

  TeacherAdd([this.teachers = const []]) : super([teachers]);

  @override
  String toString() {
    return 'TeacherAdd';
  }
}

class TeacherLoaded extends TeacherState {
  final List<Teacher> teachers;

  TeacherLoaded([this.teachers = const []]) : super([teachers]);

  @override
  String toString() {
    return 'TeacherLoaded';
  }
}

class TeacherLoading extends TeacherState {
  @override
  String toString() {
    return 'TeacherLoading';
  }
}

class TeacherLoadingError extends TeacherState {
  @override
  String toString() {
    return 'TeacherNotLoaded';
  }
}

class SuccessfulSubmission extends TeacherState{
  @override
  String toString() {
  return "Successfuly submitted";
   }
}

class DeleteConfirmation extends TeacherState{
  final Teacher teacher;
  final List<Teacher> teachers;

  DeleteConfirmation(this.teachers, [this.teacher]):super([teachers,teacher]);

  @override
  String toString(){
    return 'TeacherDeleteConfirmation';
  }
}
