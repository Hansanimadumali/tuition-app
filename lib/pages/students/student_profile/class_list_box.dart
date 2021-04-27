import 'package:flutter/material.dart';

class ClassListBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 0.0,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      children: <Widget>[
        InputChip(
            label: Text("Grade 7 maths"),
            onDeleted: () {
              print('I deleted');
            },
            deleteIcon: Icon(Icons.cancel)),
        InputChip(
            label: Text("Grade 7 maths"),
            onDeleted: () {
              print('I deleted');
            },
            deleteIcon: Icon(Icons.cancel)),
        InputChip(
            label: Text("Grade 7 maths"),
            onDeleted: () {
              print('I deleted');
            },
            deleteIcon: Icon(Icons.cancel)),
//        Chip(
//          label: Text(
//            "Add Class",
//            style: TextStyle(color: Colors.white),
//          ),
//          backgroundColor: Colors.black,
//        ),
      ],
    );
  }
}
