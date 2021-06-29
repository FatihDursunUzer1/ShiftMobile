import 'package:flutter/material.dart';
import 'package:shift/app/Constants/ColorTable.dart';

Container greenContainer({required child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal:16),
    decoration: BoxDecoration(
        color: colorTable['green'], borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: EdgeInsets.all(18),
      child: child,
    ),
  );
}
