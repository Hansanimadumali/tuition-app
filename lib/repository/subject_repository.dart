import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/repository/repository.dart';
import 'package:tution_app/services/firebase_data_provider.dart';

final String SUBJECT_COLLECTION = 'subjects';

class SubjectRepository implements Repository<Subject>{


  SubjectRepository(){
  }

  @override
  Future<List<Subject>> getAll() async{
    List<Subject> _subjectList = new List();
    QuerySnapshot list =await Store.getAll(SUBJECT_COLLECTION);
    for(DocumentSnapshot document in list.documents){
      _subjectList.add(Subject.fromDocumentSnapshot(document));
    }
    return _subjectList;
  }

  @override
  Future<Null> add(Subject subject) async{
    await Store.add(SUBJECT_COLLECTION, subject.toMap());
  }

  @override
  Future<Null> update(Subject subject) async{
    await Store.update(SUBJECT_COLLECTION, subject.toMap());
  }

  @override
  Future<Null> delete(Subject subject) async{
    await Store.delete(SUBJECT_COLLECTION, subject.toMap());

  }

}