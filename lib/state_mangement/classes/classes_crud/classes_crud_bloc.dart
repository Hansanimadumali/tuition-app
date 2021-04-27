import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tution_app/repository/class_repository.dart';
import 'package:tution_app/state_mangement/classes/classes_crud/classes_crud_sm.dart';

class ClassCrudBloc extends Bloc<ClassAddEvent, ClassAddState> {
  final ClassRepository classRepository;

  ClassCrudBloc({@required this.classRepository})
      : assert(classRepository != null);

  @override
  ClassAddState get initialState => ClassAddState.empty();

  @override
  Stream<ClassAddState> mapEventToState(ClassAddEvent event) async* {
    if (event is ClassNameChanged) {
      yield* _mapClassNameChangedToState(event);
    } else if (event is ClassFeeChanged) {
      yield* _mapClassFeeChangedToState(event);
    } else if (event is InstituteFeeChanged) {
      yield* _mapInstituteFeeChangeToState(event);
    } else if (event is ClassSaveButtonPressed) {
      yield* _mapSaveButtonPressedToState(event);
    }
  }

  Stream<ClassAddState> _mapClassNameChangedToState(
      ClassNameChanged event) async* {
    yield currentState.update(
        isClassNameValid: Validators.isNameValid(event.className));
  }

  Stream<ClassAddState> _mapClassFeeChangedToState(
      ClassFeeChanged event) async* {
    yield currentState.update(
        isClassFeeValid:
            Validators.isClassFeeValid(event.classFee, event.insituteFee));
  }

  Stream<ClassAddState> _mapInstituteFeeChangeToState(
      InstituteFeeChanged event) async* {
    yield currentState.update(
        isInstituteFeeValid:
            Validators.isInstituteFeeValid(event.instituteFee, event.classFee));
  }

  Stream<ClassAddState> _mapSaveButtonPressedToState(
      ClassSaveButtonPressed event) async* {
    yield ClassAddState.loading();
    try {
      if (event.tutionClass.id == null) {
        await classRepository.add(event.tutionClass);
      }
      yield ClassAddState.success();
    } catch (e) {
      yield ClassAddState.failure();
    }
  }
}

class Validators {
  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z0-9-/]');

  static isNameValid(String name) {
    return _nameRegExp.hasMatch(name);
  }

  static isClassFeeValid(double classFee, double instituteFee) {
    if (classFee < instituteFee) return false;
    if (classFee > 10000) return false;
    return true;
  }

  static isInstituteFeeValid(double instituteFee, double classFee) {
    if (classFee < instituteFee) return false;
    if (classFee > 10000) return false;
    return true;
  }
}
