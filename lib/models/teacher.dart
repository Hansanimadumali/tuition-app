
import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher{
  Teacher(this.id,this.name,this.telephone);

  Teacher.empty(){
    this.id="";
    this.name = "";
    this.telephone = "";
  }

  String id;
  String name;
  String telephone;

  Teacher.fromMap(Map<dynamic, dynamic> json){
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
  }

  Teacher.fromDocumentSnapshot(DocumentSnapshot document){
    id =document.documentID;
    name =document.data['name'];
    telephone =document.data['telephone'];
  }

  toMap(){
    return {
      'id': id,
      'name': name,
      'telephone': telephone
    };
  }

  
}