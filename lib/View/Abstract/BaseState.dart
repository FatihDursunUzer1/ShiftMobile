import 'package:flutter/material.dart';
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  double dynamicHeight(double value) =>
      MediaQuery.of(context).size.height * value;

  double dynamicWidth(double value) =>
      MediaQuery.of(context).size.width * value;

  double dynamicAppBarWidth(double value) =>
      AppBar().preferredSize.width * value;

  double dynamicAppBarHeight(double value) =>
      AppBar().preferredSize.height * value;

}