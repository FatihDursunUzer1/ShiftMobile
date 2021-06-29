import 'package:flutter/material.dart';
import 'package:shift/CommonWidget/CircularProgressBar.dart';
import 'package:shift/View/HomePage.dart';
import 'package:shift/View/LoginPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
    return CircularProgressBar();
  }
}
