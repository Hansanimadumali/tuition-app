import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tution_app/models/institute.dart';
import 'package:tution_app/repository/repository.dart';
import 'package:tution_app/services/firebase_data_provider.dart';

final String INSTITUTE_COLLECTION = 'institutes';
class InstituteRepository implements Repository<Institute>{


  InstituteRepository(){
 
  }

  @override
  Future<List<Institute>> getAll() async{
    List<Institute> _instituteList = new List();
    QuerySnapshot list = await Store.getAll(INSTITUTE_COLLECTION);
    for(DocumentSnapshot document in list.documents){
      _instituteList.add(Institute.fromDocumentSnapshot(document));
    }
    return _instituteList;
  }

  @override
  Future<Null> add(Institute institute) async{
    await Store.add(INSTITUTE_COLLECTION,institute.toMap());
  }

  @override
  Future<Null> update(Institute institute) async{
    await Store.update(INSTITUTE_COLLECTION, institute.toMap());
  }

  @override
  Future<Null> delete(Institute institute) async{
    await Store.delete(INSTITUTE_COLLECTION,institute.toMap());
  }

}