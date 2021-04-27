import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _showLogo()),
    );
  }

   Widget _showLogo() {
    return new Hero(
        tag: 'hero',
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('assets/flutter-icon.png')),
        ));
  }
}