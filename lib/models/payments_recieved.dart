import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class PaymentReceived {
  final String type;
  final int count;
  final charts.Color color;

  PaymentReceived(this.type, this.count, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
