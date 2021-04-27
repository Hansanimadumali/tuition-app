  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var formatter = DateFormat.jm();

String createDateString(TimeOfDay time) {
  
    var now =DateTime.now();
    var buildDateTime = DateTime(now.year,now.month,now.day,time.hour,time.minute);

    return formatter.format(buildDateTime);

  }