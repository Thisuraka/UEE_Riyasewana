import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  String text;

  CustomButton2({required this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: new BoxConstraints(
          minWidth: 120.0,
          maxWidth: 200.0,
          minHeight: 22.0,
          maxHeight: 22.0,
        ),
        child: new DecoratedBox(
          decoration: new BoxDecoration(
              border: Border.all(color: Button2BorderColor),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
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
        ));
  }
}
