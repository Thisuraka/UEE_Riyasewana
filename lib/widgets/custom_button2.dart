import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  String text;

  CustomButton2({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 22.0,
      decoration: BoxDecoration(
          border: Border.all(color: Button2BorderColor),
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 11,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
