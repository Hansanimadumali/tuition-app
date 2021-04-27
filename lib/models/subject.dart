import 'package:cloud_firestore/cloud_firestore.dart';

class Subject{
  Subject(this.id,this.name);

  Subject.empty(){
    this.id="";
    this.name="";
  }

  String id;
  String name;

  Subject.fromDocumentSnapshot(DocumentSnapshot document){
    id =document.documentID;
    name =document.data['name'];
  }

  Subject.fromMap(Map<dynamic,dynamic> map){
    id =map['id'] as String;
    name =map['name'];
  }

  toMap(){
    return {
      'id':id,
      'name': name
    };
  }
}