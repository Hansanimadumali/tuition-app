import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/tution_class.dart';

@immutable
abstract class ClassListEvent extends Equatable {
  ClassListEvent([List props = const []]) : super(props);
}

class LoadClassList extends ClassListEvent{
  @override
  String toString() {
    return 'LoadClassList';
  }
}


class NavigateAddScreen extends ClassListEvent{
  @override
  String toString() {
    return 'NavigateToAddScreen';
  }
}

class SelectMultipleClasses extends ClassListEvent{
  final TutionClass tutionClass;

  SelectMultipleClasses({this.tutionClass}):super([tutionClass]);

  @override
  String toString() {
    return "SelectPressedClass";
  }
}


class CancelSelectMultiple extends ClassListEvent{
  @override
  String toString() {
    return 'Cancel Selected Classes';
  }
}


class ShowLoadedClasses extends ClassListEvent{
  @override
  String toString() {
    return 'Show loaded classes';
  }
}