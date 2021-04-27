import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tution_app/models/institute.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/models/subject.dart';
import 'package:tution_app/models/teacher.dart';

class TutionClass{
  String id;
  String className;
  Institute institute;
  int grade;
  Teacher teacher;
  Subject subject;
  String medium;
  double instituteFee;
  double classFee;
  String endDate;
  List<Student> studentList;

  TutionClass(
      {this.id, this.className, this.grade, this.subject, this.teacher, this.institute, this.medium, this.instituteFee, this.classFee, this.endDate, this.studentList});


  String toString(){
    return this.className+" "+this.grade.toString()+" "+this.subject.name+" "+this.teacher.name+" "+this.institute.name;
  }

  copyFrom(TutionClass tutionClass){
    this.id = tutionClass.id;
    this.classFee = tutionClass.classFee;
    this.instituteFee = tutionClass.instituteFee;
    this.className = tutionClass.className;
    this.grade = tutionClass.grade;
    this.teacher = tutionClass.teacher;
    this.subject = tutionClass.subject;
    this.medium = tutionClass.medium;
    this.institute = tutionClass.institute;
    this.endDate = tutionClass.endDate;
    this.studentList = tutionClass.studentList;
  }

  TutionClass.fromDocumentSnapshot(DocumentSnapshot document){
    this.id = document.documentID;
    this.className = document.data['className'];
    this.classFee = document.data['classFee'];
    this.institute = Institute.fromMap(document.data['institute']) ;
    this.grade = document.data['grade'];
    this.teacher = Teacher.fromMap(document.data['teacher']);
    this.medium = document.data['medium'];
    this.instituteFee = document.data['instituteFee'];
    this.subject = Subject.fromMap(document.data['subject']);
    this.endDate = document.data['endDate'];
    this.studentList = document.data['studentList'];
  }

  toMap(){
    return {
      'id':id,
      'className':className,
      'classFee':classFee,
      'institute':institute.toMap(),
      'grade': grade,
      'teacher':teacher.toMap(),
      'medium':medium,
      'instituteFee':instituteFee,
      'subject':subject.toMap(),
      'endDate':endDate
    };
  }
}