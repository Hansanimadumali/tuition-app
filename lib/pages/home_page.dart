import 'package:flutter/material.dart';
import 'package:tution_app/pages/classes/class_list.dart';
import 'package:tution_app/pages/dashboard/home.dart';
import 'package:tution_app/pages/drawer/drawer_container.dart';
import 'package:tution_app/pages/messages/messeage_page.dart';
import 'package:tution_app/pages/payments/payment_class_list.dart';
import 'package:tution_app/pages/students/student_list/student_list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.userId}) : super(key: key);

  final String userId;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Tution App";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
//  final List<Widget> homeScreens = [
//    Home(),
//    ClassList(),
//    StudentList(),
//    PaymentClassList(),
//    MessagePage()
//  ];

  @override
  void initState() {
    super.initState();
    _counter = 0;
  }

  void _changePage(int index) {
    setState(() {
      _counter = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Drawer(child: DrawerContainer()),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: _selectPage(_counter)
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _counter,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
              title: new Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.event, color: Colors.grey),
              title: new Text('Classes')),
          BottomNavigationBarItem(
              icon: Icon(Icons.face, color: Colors.grey),
              title: new Text('Students')),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on, color: Colors.grey),
              title: new Text('Earnings')),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment, color: Colors.grey),
              title: new Text('Messages')),
        ],
        onTap: (index) {
          _changePage(index);
        },
      ),
    );
  }
  
  
  Widget _selectPage(int index){
    if(index == 1){
      return ClassList();
    }else if(index == 2){
      return StudentList();
    }else if(index == 3){
      return PaymentClassList();
    }else if(index == 4){
      return MessagePage();
    }
    return Home();
  }
}
