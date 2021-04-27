import 'package:flutter/material.dart';

class StudentPayment extends StatefulWidget {
  @override
  _StudentPaymentState createState() => _StudentPaymentState();
}

class _StudentPaymentState extends State<StudentPayment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        child: Column(
          children: <Widget>[
            _getHeading(context),
            SizedBox(
              height: 8.0,
            ),
            _getPaymentDetails()
          ],
        ),
      ),
    );
  }

  void _filterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Text("Hello"),
          );
        });
  }

  Widget _getHeading(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Color(0xffececec), borderRadius: BorderRadius.circular(25.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50,
            child: Center(
                child: Text(
              "JD",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )),
            decoration: BoxDecoration(
              color: Color(0xff142d4c),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          Container(
              child: Center(
            child: Text(
              "Kusal",
              style: TextStyle(fontSize: 18.0),
            ),
          )),
          Container(
            width: 50,
            child: Center(
                child: IconButton(
              color: Color(0xff142d4c),
              onPressed: () {
                _filterModalBottomSheet(context);
              },
              icon: Icon(Icons.tune),
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPaymentDetails() {
    return Expanded(
      child: Container(
        child: ListView(
          children: <Widget>[
            _duePayment(),
            _finishedPayment(),
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  
            _finishedPayment(),  

          ],
        ),
      ),
    );
  }

  Card _duePayment() {
    return Card(
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 50.0,
                child: Icon(
                  Icons.credit_card,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Classe Grade 7 p"),
                  Text(
                    "25 May 2019",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text("Rs. 500",
                      style: TextStyle(color: Colors.red, fontSize: 20.0)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text("PAY",
                      style: TextStyle(color: Colors.red, fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Card _finishedPayment() {
    return Card(
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 50.0,
                child: Icon(
                  Icons.credit_card,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Classe Grade 7 p"),
                  Text(
                    "25 May 2019",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text("Rs. 500", style: TextStyle(fontSize: 20.0)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text("PAID",
                      style: TextStyle(color: Colors.green, fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
