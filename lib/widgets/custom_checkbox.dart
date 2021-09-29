import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  String text;
  double width = 330.0;
  double height;
  bool selected;
  bool small;

  CustomCheckbox(
      {required this.text,
      required this.width,
      this.height = 45.0,
      this.small = false,
      this.selected = false});

  @override
  _CustomCheckboxScreen createState() => _CustomCheckboxScreen();
}

class _CustomCheckboxScreen extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selected = !widget.selected;
        });
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: widget.selected
                    ? <Color>[
                        Color(0xFF12A1FF),
                        Color(0xFF2980B9),
                      ]
                    : <Color>[
                        Colors.white,
                        Colors.white,
                      ]),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            border: widget.selected ? null : Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: widget.small
                ? EdgeInsets.symmetric(vertical: 9)
                : EdgeInsets.symmetric(vertical: 13),
            child: Text(
              widget.text,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: widget.selected ? Colors.white : Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: widget.small ? 11 : 16,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}


// Checkbox(
//                 value: _selected,
//                 checkColor: DefaultColor,
//                 onChanged: (value) {
//                   setState(() {
//                     _selected = value!;
//                   });
//                 },
//               ),
