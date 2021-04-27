import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:tution_app/models/institute.dart';
import 'package:tution_app/repository/institute_repository.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_event.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_state.dart';

class InstituteBloc extends Bloc<InstituteEvent, InstituteState> {
  final InstituteRepository instituteRepository;

  InstituteBloc({@required this.instituteRepository})
      : assert(instituteRepository != null);

  InstituteState get initialState => InstituteLoading();

  @override
  Stream<InstituteState> mapEventToState(InstituteEvent event) async* {
    if (event is LoadInstitutes) {
      yield* _mapLoadInstituteToState();
    } else if (event is AddButtonPressed) {
      yield* _mapAddButtonPressedToState();
    } else if (event is EditButtonPressed) {
      yield* _mapEditButtonPressedToState(event);
    } else if (event is CancelButtonPressed) {
      yield* _mapCancelButtonPressedToState();
    } else if (event is SaveButtonPressed) {
      yield* _mapSaveButtonPressedToState(event.id, event.name, event.location);
    } else if (event is DeleteButtonPressed) {
      yield* _mapDeleteButtonPressedToState(event);
    } else if (event is DeleteConfirmationButtonPressed) {
      yield* _mapDeleteConfirmationButtonPressedToState(event);
    }
  }

  Stream<InstituteState> _mapLoadInstituteToState() async* {
    yield InstituteLoading();
    try {
      final institutes = await this.instituteRepository.getAll();
      yield InstituteLoaded(institutes);
    } catch (_) {
      yield InstituteLoadingError();
    }
  }

  Stream<InstituteState> _mapAddButtonPressedToState() async* {
    if (currentState is InstituteLoaded) {
      final List<Institute> list =
          List.from((currentState as InstituteLoaded).institutes);
      yield InstituteAdd(list);
    }
  }

  Stream<InstituteState> _mapEditButtonPressedToState(
      EditButtonPressed event) async* {
    if (currentState is InstituteLoaded) {
      final List<Institute> list =
          List.from((currentState as InstituteLoaded).institutes);
      yield InstituteEdit(list, event.institute.id);
    }
  }

  Stream<InstituteState> _mapCancelButtonPressedToState() async* {
    if(currentState is InstituteAdd){
      final List<Institute> list = List.from((currentState as InstituteAdd).institutes);
      yield InstituteLoaded(list);
    }
    if(currentState is InstituteEdit){
      final List<Institute> list = List.from((currentState as InstituteAdd).institutes);
      yield InstituteLoaded(list);
    }
    if(currentState is DeleteConfirmation){
      final List<Institute> list = List.from((currentState as DeleteConfirmation).institutes);
      yield InstituteLoaded(list);
    }
  }

  Stream<InstituteState> _mapSaveButtonPressedToState(
      String id, String name, String location) async* {
    yield InstituteLoading();
    try {
      if (id == null) {
        Institute institute = Institute(id, name, location);
        await this.instituteRepository.add(institute);
        yield SuccessfulSubmission();
      } else {
        Institute institute = Institute(id, name, location);
        await this.instituteRepository.update(institute);
        yield SuccessfulSubmission();
      }
    } catch (e) {
      yield InstituteLoadingError();
    }
  }

  Stream<InstituteState> _mapDeleteButtonPressedToState(
      DeleteButtonPressed event) async* {
        List<Institute> instituteList;
        if(currentState is InstituteLoaded){
          instituteList = List.from((currentState as InstituteLoaded).institutes);
        }
        if(currentState is InstituteAdd){
          instituteList = List.from((currentState as InstituteAdd).institutes);
        }
        if(currentState is InstituteEdit){
          instituteList = List.from((currentState as InstituteLoaded).institutes);
        }

      if(instituteList != null){
        yield DeleteConfirmation(instituteList, event.institute);
      }
  }

  Stream<InstituteState> _mapDeleteConfirmationButtonPressedToState(
      DeleteConfirmationButtonPressed event) async* {
    yield InstituteLoading();

    try {
      await this.instituteRepository.delete(event.institute);
      yield SuccessfulSubmission();
    } catch (e) {
      yield InstituteLoadingError();
    }
  }
}
