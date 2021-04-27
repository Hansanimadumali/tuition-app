import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/services/student_service.dart';

class ProfileAvatar extends StatelessWidget {
  final Student student;

  const ProfileAvatar({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (student.avatar != null) {
      return Container(
          height: 130.0,
          width: 130.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(65.0),
              color: Color(0xffececec)),
          child: ClipOval(
            child: Image(
                height: 130.0,
                width: 130.0,
                fit: BoxFit.cover,
                image: NetworkImage(student.avatar)

//              AdvancedNetworkImage(
//                _student.avatar,
//                useDiskCache: true,
//                cacheRule: CacheRule(maxAge: const Duration(days: 7)),
//              ),
                ),
          ));
    }
    return Container(
      height: 130.0,
      width: 130.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(65.0), color: Color(0xff142d4c)),
      child: Center(
        child: Text(createNameInitials(student),
            style: TextStyle(color: Colors.white, fontSize: 50.0)),
      ),
    );
  }
}
