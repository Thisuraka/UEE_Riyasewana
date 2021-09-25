import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomColTextbox extends StatelessWidget {
  int maxLine;
  String header;
  String info;

  bool obscureText;

  CustomColTextbox({
    required this.header,
    required this.info,
    this.maxLine = 1,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 35,
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          header,
          style: TextStyle(
              color: Color(0xFF858585),
              fontSize: 15.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        // height: 40,
        width: 200,
        margin: EdgeInsets.only(left: 170),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          info,
          maxLines: 5,
          style: TextStyle(
              color: Color(0xFF858585),
              fontSize: 15.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    ]);
  }
}
