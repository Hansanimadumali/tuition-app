import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/repository/repository.dart';
import 'package:tution_app/services/firebase_data_provider.dart';

final String STUDENT_COLLECTION = 'students';

class StudentRepository implements Repository<Student> {
  final firebaseStorage = FirebaseStorage.instance;
  StudentRepository() {}

  @override
  Future<List<Student>> getAll() async {
    List<Student> _studentList = new List();
    QuerySnapshot list = await Store.getAll(STUDENT_COLLECTION);
    for (DocumentSnapshot document in list.documents) {
      _studentList.add(Student.fromDocumentSnapshot(document));
    }
    return _studentList;
  }

  @override
  Future<Null> add(Student student) async {
    await Store.add(STUDENT_COLLECTION, student.toMap());
  }

  @override
  Future<Null> update(Student student) async {
    await Store.update(STUDENT_COLLECTION, student.toMap());
  }

  @override
  Future<Null> delete(Student student) async {
    await Store.delete(STUDENT_COLLECTION, student.toMap());
  }

  Future<String> uploadImage(String fileName, File image) async {
    final StorageReference storageReference =
    firebaseStorage.ref().child('profile-images/$fileName');
    final StorageUploadTask storageUploadTask = storageReference.putFile(image);
    final StorageTaskSnapshot storageTaskSnapshot =
    await storageUploadTask.onComplete;
    final String url = await storageTaskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<Null> deleteImage(String url) async{
    StorageReference storageReference = await firebaseStorage.getReferenceFromUrl(url);
    storageReference.delete();
  }

  Future<Null> deleteMultiple(List<Student> list) async{
    for(Student student in list){
      delete(student);
    }
  }
}
