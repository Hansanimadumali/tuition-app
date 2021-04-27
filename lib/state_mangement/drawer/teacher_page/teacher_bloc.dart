import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tution_app/models/teacher.dart';
import 'package:tution_app/repository/teacher_repository.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_event.dart';
import 'package:tution_app/state_mangement/drawer/teacher_page/teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final TeacherRepository teacherRepository;


  TeacherBloc({@required this.teacherRepository})
      : assert(teacherRepository != null);

  TeacherState get initialState => TeacherLoading();

  @override
  Stream<TeacherState> mapEventToState(TeacherEvent event) async* {
    if (event is LoadTeachers) {
      yield* _mapLoadTeacherToState();
    } else if (event is AddButtonPressed) {
      yield* _mapAddButtonPressedToState();
    } else if (event is EditButtonPressed) {
      yield* _mapEditButtonPressedToState(event);
    } else if (event is CancelButtonPressed) {
      yield* _mapCancelButtonPressedToState();
    } else if (event is SaveButtonPressed) {
      yield* _mapSaveButtonPressedToState(
          event.id, event.name, event.telephone);
    } else if (event is DeleteButtonPressed) {
      yield* _mapDeleteButtonPressedToState(event);
    } else if(event is DeleteConfirmationButtonPressed){
      yield* _mapDeleteConfirmationButtonPressedToState(event);
    }
  }

  Stream<TeacherState> _mapLoadTeacherToState() async* {
    yield TeacherLoading();
    try {
      final teachers = await this.teacherRepository.getAll();
      yield TeacherLoaded(teachers);
    } catch (_) {
      yield TeacherLoadingError();
    }
  }

  Stream<TeacherState> _mapAddButtonPressedToState() async* {
    if(currentState is TeacherLoaded){
      final List<Teacher> teacherList = List.from((currentState as TeacherLoaded).teachers);
      yield TeacherAdd(teacherList);
    }
  }

  Stream<TeacherState> _mapEditButtonPressedToState(
      EditButtonPressed event) async* {
      if(currentState is TeacherLoaded){
      final List<Teacher> teacherList = List.from((currentState as TeacherLoaded).teachers);
        yield TeacherEdit(teacherList, event.teacher.id);
      }

  }

  Stream<TeacherState> _mapCancelButtonPressedToState() async* {
    if(currentState is TeacherEdit){
      final List<Teacher> teacherList = List.from((currentState as TeacherEdit).teachers);      
      yield TeacherLoaded(teacherList);
    }
     if(currentState is TeacherAdd){
      final List<Teacher> teacherList = List.from((currentState as TeacherAdd).teachers);      
      yield TeacherLoaded(teacherList);
    }

     if(currentState is DeleteConfirmation){
      final List<Teacher> teacherList = List.from((currentState as DeleteConfirmation).teachers);      
      yield TeacherLoaded(teacherList);
    }

  }

  Stream<TeacherState> _mapSaveButtonPressedToState(
      String id, String name, String telephone) async* {
    yield TeacherLoading();
    try {
      if (id == null) {
        Teacher teacher = Teacher(id, name, telephone);
        await this.teacherRepository.add(teacher);
        yield SuccessfulSubmission();
      } else {
        Teacher teacher = Teacher(id, name, telephone);
        await this.teacherRepository.update(teacher);
        yield SuccessfulSubmission();
      }
    } catch (e) {
      yield TeacherLoadingError();
    }
  }

  Stream<TeacherState> _mapDeleteButtonPressedToState(DeleteButtonPressed event) async*{
    List<Teacher> teacherList;
    if(currentState is TeacherEdit){
      teacherList = List.from((currentState as TeacherEdit).teachers);      
    }else if(currentState is TeacherAdd){
      teacherList = List.from((currentState as TeacherAdd).teachers);      
    }else if(currentState is TeacherLoaded){
      teacherList = List.from((currentState as TeacherLoaded).teachers);            
    }
    if(teacherList!=null){
      yield DeleteConfirmation(teacherList,event.teacher);
    }
  }

  Stream<TeacherState> _mapDeleteConfirmationButtonPressedToState(
      DeleteConfirmationButtonPressed event) async* {
    yield TeacherLoading();

    try {
      await this.teacherRepository.delete(event.teacher);
      yield SuccessfulSubmission();
    } catch (e) {
      yield TeacherLoadingError();
    }
  }
}
