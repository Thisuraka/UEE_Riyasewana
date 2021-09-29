import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String text;
  double width = 330.0;
  double height;

  CustomButton({
    required this.text,
    required this.width,
    this.height = 45.0,
  });

  @override
  _CustomButtonScreen createState() => _CustomButtonScreen();
}

class _CustomButtonScreen extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color(0xFF12A1FF),
            Color(0xFF2980B9),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 13),
          child: Text(
            widget.text,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
