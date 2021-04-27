
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tution_app/models/tution_class.dart';

class Student{
  String id;
  String firstName;
  String lastName;
  int grade;
  String parentType;
  String mobile;
  String parentMobile;
  String school;
  String avatar;
  List<TutionClass> classList;

  Student(this.id,this.firstName,
      this.lastName, this.grade, this.parentType, this.parentMobile,
      this.mobile, this.school, this.avatar, this.classList);


  String toString(){
    return firstName+" "+lastName+" grade "+grade.toString();
  }

  copyFrom(Student student){
    this.firstName = student.firstName;
    this.lastName =student.lastName;
    this.grade =student.grade;
    this.parentType =student.parentType;
    this.mobile =student.mobile;
    this.parentMobile =student.parentMobile;
    this.school =student.school;
    this.avatar =student.avatar;
    this.classList = student.classList;
  }

  Student.basic(this.id,this.firstName,this.lastName,this.grade);

  Student.fromDocumentSnapshot(DocumentSnapshot document){
    this.id =document.documentID;
    this.firstName =document['firstName'];
    this.lastName =document['lastName'];
    this.grade =document['grade'];
    this.parentType=document['parentType'];
    this.parentMobile=document['parentMobile'];
    this.mobile =document['mobile'];
    this.school=document['school'];
    this.avatar=document['avatar'];
    this.classList = document['classList'];
  }

  toMap(){
    return {
      'id': id,
      'firstName':firstName,
      'lastName':lastName,
      'grade':grade,
      'parentType':parentType,
      'parentMobile':parentMobile,
      'mobile':mobile,
      'school':school,
      'avatar':avatar
    };
  }
}

