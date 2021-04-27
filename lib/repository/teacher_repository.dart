import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tution_app/models/teacher.dart';
import 'package:tution_app/repository/repository.dart';
import 'package:tution_app/services/firebase_data_provider.dart';

final String TEACHER_COLLECTION = 'teachers';
class TeacherRepository implements Repository<Teacher>{


  TeacherRepository(){
  }

  @override
  Future<List<Teacher>> getAll() async{
    List<Teacher> _teacherList = new List();    
    QuerySnapshot list = await Store.getAll(TEACHER_COLLECTION);
    for(DocumentSnapshot document in list.documents){
      _teacherList.add(Teacher.fromDocumentSnapshot(document));
    }
    return _teacherList;
  }

  @override
  Future<Null> add(Teacher teacher) async{
    await Store.add(TEACHER_COLLECTION,teacher.toMap());
  }

  @override
  Future<Null> update(Teacher teacher) async{
    await Store.update(TEACHER_COLLECTION, teacher.toMap());
  }

  @override
  Future<Null> delete(Teacher teacher) async{
    await Store.delete(TEACHER_COLLECTION, teacher.toMap());
  }

}