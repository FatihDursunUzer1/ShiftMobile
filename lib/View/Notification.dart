import 'package:flutter/material.dart';
import 'package:shift/View/Abstract/BaseState.dart';


class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends BaseState<Notification> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Bildirim Sayfası"),);
  }
}
