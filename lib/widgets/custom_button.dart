import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  double width = 330.0;

  CustomButton({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: width,
        height: 45.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF12A1FF),
                Color(0xFF2980B9),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            text,
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
