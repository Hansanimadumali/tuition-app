import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class Store {
  static final Firestore _firestore = Firestore.instance;

  static Future<Null> add(String collection, Map data) async{
    _firestore.collection(collection).document().setData(data);
  }

  static Future<QuerySnapshot> getAll(String collection) async{
    return _firestore.collection(collection).getDocuments();
  }

  static Future<Null> update(String collection,Map data) async{
    _firestore.collection(collection).document(data['id']).updateData(data);
  }

  static Future<Null> delete(String collection,Map data) async{
    _firestore.collection(collection).document(data['id']).delete();
  }
}