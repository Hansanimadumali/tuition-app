import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/repository/student_repository.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  final StudentRepository studentRepository;

  StudentListBloc({@required this.studentRepository})
      : assert(studentRepository != null);

  StudentListState get initialState => StudentListLoading(new List());

  @override
  Stream<StudentListState> mapEventToState(StudentListEvent event) async* {
    if (event is LoadStudentList) {
      yield* _mapLoadStudentListToState(event);
    } else if (event is ShowLoadedStudents) {
      yield* _mapShowLoadedStudentsToState();
    } else if (event is NavigateAddScreen) {
      yield* _mapNavigateToAddScreenToState();
    } else if (event is SelectMultipleStudents) {
      yield* _mapSelectMultipleStudentsToState(event);
    } else if (event is CancelSelectMultiple) {
      yield* _mapCancelSelectMultipleToState();
    } else if (event is DeleteMultiple){
      yield* _mapDeleteMultipleToState();
    } else if (event is CancelDeleteMultipleConfirmation){
      yield* _mapCancelDeleteMultipleConfirmationToState();
    } else if (event is DeleteMultipleConfirmationButtonPressed){
      yield* _mapDeleteMultipleConfirmationButtonPressedToState();
    }
  }

  Stream<StudentListState> _mapLoadStudentListToState(
      LoadStudentList event) async* {
    if (currentState is StudentListLoaded) {
      yield StudentListLoading((currentState as StudentListLoaded).students);
    } else if (currentState is SuccessfulSubmission)
      yield StudentListLoading((currentState as SuccessfulSubmission).students);
    else {
      yield StudentListLoading(new List());
    }
    try {
      final students = await this.studentRepository.getAll();
      yield StudentListLoaded(students);
    } catch (e) {
      yield StudentListLoadingError();
    }
  }

  Stream<StudentListState> _mapNavigateToAddScreenToState() async* {
    yield LoadingToAddScreen((currentState as StudentListLoaded).students);
  }

  Stream<StudentListState> _mapSelectMultipleStudentsToState(
      SelectMultipleStudents event) async* {
    List<Student> studentList;
    List<Student> studentSelectedList;
    if (currentState is StudentListLoaded) {
      studentList = new List()
        ..addAll((currentState as StudentListLoaded).students);
      studentSelectedList = new List()
        ..add(event.student);
    }
    if (currentState is StudentMultipleSelectList) {
      StudentMultipleSelectList state = currentState as StudentMultipleSelectList;
      studentList = new List()
        ..addAll(state.students);
      if (state.selectedStudents.contains(event.student)) {
        List<Student> list = new List();
        for (Student student in state.selectedStudents) {
          if (event.student != student) {
            list.add(student);
          }
        }
        studentSelectedList = list;
      } 
      
      else {
        studentSelectedList = new List()
          ..addAll((currentState as StudentMultipleSelectList).selectedStudents)
          ..add(event.student);
      }
    }
    
    if(state is MultipleDeleteConfirmation){
      studentList = new List()
        ..addAll((currentState as MultipleDeleteConfirmation).students);
      studentSelectedList = new List()
        ..addAll((currentState as MultipleDeleteConfirmation).selectedStudents);
    }

    yield StudentMultipleSelectList(studentList, studentSelectedList);
  }

  Stream<StudentListState> _mapCancelSelectMultipleToState() async* {
    yield StudentListLoaded(
        (currentState as StudentMultipleSelectList).students);
  }

  Stream<StudentListState> _mapDeleteMultipleToState() async*{
    List<Student> students = (currentState as StudentMultipleSelectList).students;
    List<Student> selectedStudents = (currentState as StudentMultipleSelectList).selectedStudents;

    yield MultipleDeleteConfirmation(students,selectedStudents);
  }

  Stream<StudentListState> _mapCancelDeleteMultipleConfirmationToState() async*{
    List<Student> students = (currentState as MultipleDeleteConfirmation).students;
    List<Student> selectedStudents = (currentState as MultipleDeleteConfirmation).selectedStudents;

    yield StudentMultipleSelectList(students,selectedStudents);
  }

  Stream<StudentListState> _mapDeleteMultipleConfirmationButtonPressedToState() async*{
    List<Student> students = (currentState as MultipleDeleteConfirmation).students;
    List<Student> selectedStudents = (currentState as MultipleDeleteConfirmation).selectedStudents;
    
    yield StudentListLoading(students);
    try{
      await studentRepository.deleteMultiple(selectedStudents);
      yield SuccessfulSubmission(students);

    }catch(e){
      yield StudentListLoadingError();
    }
  }

  Stream<StudentListState> _mapShowLoadedStudentsToState() async* {
    yield StudentListLoaded((currentState as LoadingToAddScreen).students);
  }
}
