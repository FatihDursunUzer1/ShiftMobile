
import 'package:flutter/material.dart';
import 'package:shift/CommonWidget/Empty.dart';
import 'package:shift/app/Constants/ColorTable.dart';


class EButton extends StatefulWidget {
  Function? onPressed;
  Color? backgroundColor;
  String text;
  Icon? icon;
  EButton({required this.onPressed,this.backgroundColor,required this.text, this.icon});
  @override
  _EButtonState createState() {
    return _EButtonState();
  }
}

class _EButtonState extends State<EButton> {
  @override
  Widget build(BuildContext context) {
    return Container(child:ElevatedButton(
      onPressed: widget.onPressed as void Function()?,
      style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return Colors.grey;
                return widget.backgroundColor!=null?widget.backgroundColor:colorTable['green'];
              })),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.text,
                  style:
                  TextStyle(color: Colors.white)),
              SizedBox(
                width: 10,
              ),
              widget.icon!=null?widget.icon!:Empty()
            ]),
      ),
    ));
  }
}
