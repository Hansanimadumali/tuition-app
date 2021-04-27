import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tution_app/repository/student_repository.dart';
import 'package:tution_app/state_mangement/students/student_crud/student_crud_sm.dart';
import 'package:tution_app/state_mangement/students/student_view/student_list_sm.dart';

class StudentCrudBloc extends Bloc<StudentAddEvent, StudentAddState> {
  final StudentRepository studentRepository;
  final StudentListBloc studentListBloc;

  StudentCrudBloc(
      {@required this.studentRepository, @required this.studentListBloc})
      : assert(studentRepository != null);

  StudentAddState get initialState => StudentAddState.empty();

  @override
  Stream<StudentAddState> transform(Stream<StudentAddEvent> events,
      Stream<StudentAddState> Function(StudentAddEvent event) next) {
    final observableStream = events as Observable<StudentAddEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is FirstNameChanged &&
          event is LastNameChanged &&
          event is SaveButtonPressed &&
          event is TelephoneChanged &&
          event is ParentTypeChanged &&
          event is ParentMobileChanged &&
          event is SchoolChanged);
    });

    final debounceStream = observableStream.where((event) {
      return (event is FirstNameChanged ||
          event is LastNameChanged ||
          event is SaveButtonPressed ||
          event is TelephoneChanged ||
          event is ParentTypeChanged ||
          event is ParentMobileChanged ||
          event is SchoolChanged);
    }).debounceTime(Duration(microseconds: 300));

    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<StudentAddState> mapEventToState(StudentAddEvent event) async* {
    if (event is FirstNameChanged) {
      yield* _mapFirstNameChangedToState(event);
    } else if (event is LastNameChanged) {
      yield* _mapLastNameChangedToState(event);
    } else if (event is SaveButtonPressed) {
      yield* _mapSaveButtonPressedToState(event);
    } else if (event is TelephoneChanged) {
      yield* _mapTelephoneToState(event);
    } else if (event is ParentTypeChanged) {
      yield* _mapParentTypeToState(event);
    } else if (event is ParentMobileChanged) {
      yield* _mapParentMobileToState(event);
    } else if (event is UpdateStudentList) {
      yield* _mapUpdateStudentListToState();
    }
  }

  Stream<StudentAddState> _mapFirstNameChangedToState(
      FirstNameChanged event) async* {
    yield currentState.update(
        isFirstNameValid: Validators.isValidName(event.firstName));
  }

  Stream<StudentAddState> _mapLastNameChangedToState(
      LastNameChanged event) async* {
    yield currentState.update(
        isLastNameValid: Validators.isValidName(event.lastName));
  }

  Stream<StudentAddState> _mapSaveButtonPressedToState(
      SaveButtonPressed event) async* {
    yield StudentAddState.loading();
    try {
      if (event.student.id == null) {
        if (event.imageFile != null) {
//          var image = await compressImageFile(event.imageFile);
          var generatedName = event.student.firstName.toLowerCase() +
              '-' +
              event.student.lastName.toLowerCase() +
              Random().nextInt(100000).toString() +
              '.jpg';
          String url = await studentRepository.uploadImage(
              generatedName, event.imageFile);
          event.student.avatar = url;
        }

        await studentRepository.add(event.student);
      }
      yield StudentAddState.success();
    } catch (e) {
      yield StudentAddState.failure();
    }
  }

  Stream<StudentAddState> _mapTelephoneToState(TelephoneChanged event) async* {
    yield currentState.update(
        isTelephoneValid: Validators.isValidPhoneNumber(event.telephone));
  }

  Stream<StudentAddState> _mapParentTypeToState(
      ParentTypeChanged event) async* {
    yield currentState.update(
        isParentTypeValid: Validators.isValidParentType(event.parentType));
  }

  Stream<StudentAddState> _mapParentMobileToState(
      ParentMobileChanged event) async* {
    yield currentState.update(
        isParentMobileValid: Validators.isValidPhoneNumber(event.parentMobile));
  }

  Stream<StudentAddState> _mapUpdateStudentListToState() async* {
    studentListBloc.dispatch(LoadStudentList());
    yield StudentAddState.empty();
  }
}

class Validators {
  static final RegExp _namesRegExp = RegExp(r'^[a-zA-Z]');

  static final RegExp _schoolNamesRegExp = RegExp(r'^[a-zA-Z-/]');

  static final RegExp _phoneNumber = RegExp(r'^[0-9]');

  static final List<String> _parentTypes = ["Mother", "Father", "Other"];

  static isValidName(String name) {
    return _namesRegExp.hasMatch(name);
  }

  static isValidSchoolName(String password) {
    return _schoolNamesRegExp.hasMatch(password);
  }

  static isValidGrade(int grade) {
    return grade >= 6 && grade <= 13;
  }

  static isValidPhoneNumber(String phoneNumber) {
    return _phoneNumber.hasMatch(phoneNumber) && phoneNumber.length == 10;
  }

  static isValidParentType(String parentType) {
    if (_parentTypes.contains(parentType)) {
      return true;
    }
    return false;
  }
}
