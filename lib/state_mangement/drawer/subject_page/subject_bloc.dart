import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/repository/subject_repository.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_event.dart';
import 'package:tution_app/state_mangement/drawer/subject_page/subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository subjectRepository;

  SubjectBloc({@required this.subjectRepository})
      : assert(subjectRepository != null);

  SubjectState get initialState => SubjectLoading();

  @override
  Stream<SubjectState> mapEventToState(SubjectEvent event) async* {
    if (event is LoadSubjects) {
      yield* _mapLoadSubjectToState();
    } else if (event is AddButtonPressed) {
      yield* _mapAddButtonPressedToState();
    } else if (event is EditButtonPressed) {
      yield* _mapEditButtonPressedToState(event);
    } else if (event is CancelButtonPressed) {
      yield* _mapCancelButtonPressedToState();
    } else if (event is SaveButtonPressed) {
      yield* _mapSaveButtonPressedToState(event.id, event.name);
    } else if (event is DeleteButtonPressed) {
      yield* _mapDeleteButtonPressedToState(event);
    } else if (event is DeleteConfirmationButtonPressed) {
      yield* _mapDeleteConfirmationButtonPressedToState(event);
    }
  }

  Stream<SubjectState> _mapLoadSubjectToState() async* {
    yield SubjectLoading();
    try {
      final subjects = await this.subjectRepository.getAll();
      yield SubjectLoaded(subjects);
    } catch (_) {
      yield SubjectLoadingError();
    }
  }

  Stream<SubjectState> _mapAddButtonPressedToState() async* {
    if (currentState is SubjectLoaded) {
      final List<Subject> list =
          List.from((currentState as SubjectLoaded).subjects);
      yield SubjectAdd(list);
    }
  }

  Stream<SubjectState> _mapEditButtonPressedToState(
      EditButtonPressed event) async* {
    if (currentState is SubjectLoaded) {
      final List<Subject> list =
          List.from((currentState as SubjectLoaded).subjects);
      yield SubjectEdit(list, event.subject.id);
    }
  }

  Stream<SubjectState> _mapCancelButtonPressedToState() async* {
    if (currentState is SubjectAdd) {
      final List<Subject> list =
          List.from((currentState as SubjectAdd).subjects);
      yield SubjectLoaded(list);
    }
    if (currentState is SubjectEdit) {
      final List<Subject> list =
          List.from((currentState as SubjectEdit).subjects);
      yield SubjectLoaded(list);
    }
    if (currentState is DeleteConfirmation) {
      final List<Subject> list =
          List.from((currentState as DeleteConfirmation).subjects);
      yield SubjectLoaded(list);
    }
  }

  Stream<SubjectState> _mapSaveButtonPressedToState(
      String id, String name) async* {
    yield SubjectLoading();
    try {
      if (id == null) {
        Subject subject = Subject(null, name);
        await this.subjectRepository.add(subject);
        yield SuccessfulSubmission();
      } else {
        Subject subject = Subject(id, name);
        await this.subjectRepository.update(subject);
        yield SuccessfulSubmission();
      }
    } catch (e) {
      yield SubjectLoadingError();
    }
  }

  Stream<SubjectState> _mapDeleteButtonPressedToState(
      DeleteButtonPressed event) async* {
    List<Subject> subjectList;
    if (currentState is SubjectLoaded) {
      subjectList = List.from((currentState as SubjectLoaded).subjects);
    }
    if (currentState is SubjectAdd) {
      subjectList = List.from((currentState as SubjectAdd).subjects);
    }
    if (currentState is SubjectEdit) {
      subjectList = List.from((currentState as SubjectEdit).subjects);
    }

    if (subjectList != null) {
      yield DeleteConfirmation(event.subject, subjectList);
    }
  }

  Stream<SubjectState> _mapDeleteConfirmationButtonPressedToState(
      DeleteConfirmationButtonPressed event) async* {
    yield SubjectLoading();

    try {
      await this.subjectRepository.delete(event.subject);
      yield SuccessfulSubmission();
    } catch (e) {
      yield SubjectLoadingError();
    }
  }
}
