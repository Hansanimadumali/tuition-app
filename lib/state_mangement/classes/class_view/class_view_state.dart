import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/tution_class.dart';

@immutable
class ClassViewState extends Equatable {
  ClassViewState([List props = const []]) : super(props);
}

class ClassViewLoading extends ClassViewState {
  @override
  String toString() {
    return 'LoadingClassData';
  }
}


class ClassViewLoaded extends ClassViewState{
  final TutionClass tutionClass;

  ClassViewLoaded({this.tutionClass}):super([tutionClass]);

  @override
  String toString() {
    return 'ClassViewLoaded';
  }
}