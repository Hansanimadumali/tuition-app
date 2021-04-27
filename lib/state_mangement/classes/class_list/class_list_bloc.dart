import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tution_app/models/tution_class.dart';
import 'package:tution_app/repository/class_repository.dart';
import './class_list_bloc_sm.dart';

class ClassListBloc extends Bloc<ClassListEvent, ClassListState> {
  final ClassRepository classRepository;

  ClassListBloc({this.classRepository}):assert(classRepository!=null);

  @override
  ClassListState get initialState => ClassListLoading(classList: new List());

  @override
  Stream<ClassListState> mapEventToState(ClassListEvent event,) async* {
    if(event is LoadClassList){
      yield* _mapLoadClassListToState(event);
    }else if(event is NavigateAddScreen){
      yield* _mapNavigateAddScreenToState();
    }else if(event is SelectMultipleClasses){
      yield* _mapSelectMultipleClassesToState(event);
    }else if(event is CancelSelectMultiple){
      yield* _mapCancelSelectMultipleToState(event);
    }
  }

  Stream<ClassListState> _mapLoadClassListToState(LoadClassList event) async*{
    if(currentState is ClassListLoaded){
      yield ClassListLoading(classList:(currentState as ClassListLoaded).classList);
    } else if( currentState is ClassSuccessfulSubmission){
      yield ClassListLoading(classList:(currentState as ClassSuccessfulSubmission).classList);
    } else{
      yield ClassListLoading(classList: List());
    }

    try{
      final classList = await this.classRepository.getAll();
      yield ClassListLoaded(classList: classList);
    }catch(e){
      yield ClassListLoadingError();
    }
  }

  Stream<ClassListState> _mapNavigateAddScreenToState() async*{
    yield LoadingToAddScreen(classList: (currentState as ClassListLoaded).classList);
  }

  Stream<ClassListState> _mapSelectMultipleClassesToState(SelectMultipleClasses event) async*{
    List<TutionClass> classList;
    List<TutionClass> selectedClassList;

    if(currentState is ClassListLoaded){
      classList = new List()..addAll((currentState as ClassListLoaded).classList);
      selectedClassList = new List()..add(event.tutionClass);
    }

    if(currentState is ClassMultipleSelectList){
      ClassMultipleSelectList state = currentState as ClassMultipleSelectList;
      classList = new List()..addAll(state.classList);

      if(state.selectedClassList.contains(event.tutionClass)){
        List<TutionClass> list = new List();
        for(TutionClass tutionClass in state.selectedClassList){
          if(event.tutionClass != tutionClass){
            list.add(tutionClass);
          }
        }
        selectedClassList = list;
      }
      else{
        selectedClassList = new List()..addAll(state.selectedClassList)..add(event.tutionClass);
      }
    }

    yield ClassMultipleSelectList(classList: classList,selectedClassList: selectedClassList);
  }

  Stream<ClassListState> _mapCancelSelectMultipleToState(CancelSelectMultiple event) async*{
    yield ClassListLoaded(classList: (currentState as ClassMultipleSelectList).classList);
  }


}
