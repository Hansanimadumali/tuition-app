import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StudentAttendanceChart extends StatelessWidget {
  final List<charts.Series> seriesList = _createSampleData();
  final bool animate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 130,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffececec),
              borderRadius: BorderRadius.circular(10.0)),
          child: new charts.PieChart(
            seriesList,
            animate: animate,
            defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 60,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside)
              ],
            ),
          ),
        ));
  }

  static List<charts.Series<Attendance, String>> _createSampleData() {
    final data = [
      new Attendance(65, "Came", 0xff01a332),
      new Attendance(6, "Not Came", 0xffe53516)
    ];

    return [
      new charts.Series<Attendance, String>(
          id: 'Attendance',
          domainFn: (Attendance attendance, _) => attendance.type,
          measureFn: (Attendance attendance, _) => attendance.count,
          data: data,
          colorFn: (Attendance attendance, _) =>
              charts.ColorUtil.fromDartColor(new Color(attendance.color)),
          labelAccessorFn: (Attendance attendance, _) => '${attendance.count}')
    ];
  }
}

class Attendance {
  final int count;
  final String type;
  final int color;

  Attendance(this.count, this.type, this.color);
}
