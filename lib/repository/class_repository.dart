


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tution_app/models/tution_class.dart';
import 'package:tution_app/repository/repository.dart';
import 'package:tution_app/services/firebase_data_provider.dart';

final String CLASS_COLLECTION = 'classes';

class ClassRepository implements Repository<TutionClass>{

  ClassRepository(){}

  @override
  Future<Null> add(TutionClass tutionClass) async{
    await Store.add(CLASS_COLLECTION,tutionClass.toMap());
  }

  @override
  Future<Null> delete(TutionClass tutionClass) async{
    await Store.delete(CLASS_COLLECTION, tutionClass.toMap());
  }

  @override
  Future<List<TutionClass>> getAll() async{
    List<TutionClass> _classList = new List();
    QuerySnapshot list = await Store.getAll(CLASS_COLLECTION);
    for(DocumentSnapshot document in list.documents){
      _classList.add(TutionClass.fromDocumentSnapshot(document));
    }
    return _classList;
  }

  @override
  Future<Null> update(TutionClass tutionClass) async{
    await Store.update(CLASS_COLLECTION, tutionClass.toMap());
  }

}