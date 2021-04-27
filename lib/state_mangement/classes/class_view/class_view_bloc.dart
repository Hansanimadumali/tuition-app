import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tution_app/repository/class_repository.dart';

import './class_view_sm.dart';

class ClassViewBloc extends Bloc<ClassViewEvent, ClassViewState> {
  final ClassRepository classRepository;

  ClassViewBloc({this.classRepository}):assert(classRepository!=null);

  @override
  ClassViewState get initialState => ClassViewLoading();

  @override
  Stream<ClassViewState> mapEventToState(
    ClassViewEvent event,
  ) async* {
    if (event is LoadSingleClass) {
      yield* _mapLoadSingleClassToState(event);
    }
  }

  Stream<ClassViewState> _mapLoadSingleClassToState(
      LoadSingleClass event) async* {
    yield ClassViewLoading();
    yield ClassViewLoaded(tutionClass: event.tutionClass);
  }
}
