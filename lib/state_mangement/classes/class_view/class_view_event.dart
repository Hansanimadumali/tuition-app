import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/tution_class.dart';

@immutable
abstract class ClassViewEvent extends Equatable {
  ClassViewEvent([List props = const []]) : super(props);
}

class LoadSingleClass extends ClassViewEvent{
  final TutionClass tutionClass;
  LoadSingleClass({this.tutionClass}):super([tutionClass]);
  @override
  String toString() {
    return 'LoadTutionClassBasic';
  }
}