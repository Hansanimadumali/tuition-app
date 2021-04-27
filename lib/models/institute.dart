import 'package:cloud_firestore/cloud_firestore.dart';

class Institute {
  Institute(this.id, this.name, this.location);

  Institute.empty() {
    this.id = "";
    this.name = "";
    this.location = "";
  }

  String id;
  String name;
  String location;

  Institute.fromDocumentSnapshot(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'];
    location = document.data['location'];
  }

  Institute.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.location = map['location'];
  }

  toMap() {
    return {'id': id, 'name': name, 'location': location};
  }
}
