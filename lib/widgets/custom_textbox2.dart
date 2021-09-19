import '../../styles.dart';
import 'package:flutter/material.dart';

class CustomTextBox2 extends StatelessWidget {
  TextEditingController controller;
  TextCapitalization textCapitalization;
  TextInputType keyboardType;
  bool readOnly;
  int minLine;
  int maxLine;
  String hint;
  TextStyle hintStyle;
  String labelText;
  Function onTap;
  bool enabled;

  bool obscureText;

  CustomTextBox2(
      {required this.controller,
      required this.hint,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.minLine = 1,
      this.maxLine = 1,
      this.hintStyle = HintStyle1,
      required this.labelText,
      this.obscureText = false,
      required this.enabled,
      required this.onTap});

  static InputBorder enabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 0.5),
  );

  static InputBorder errorBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
        child: TextFormField(
          style: TextStyle(fontSize: 16.0),
          maxLines: maxLine,
          minLines: minLine,
          keyboardType: keyboardType,
          autofocus: false,
          textCapitalization: textCapitalization,
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: () {
            onTap;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            hintText: hint,
            hintStyle: HintStyle1,
            labelText: labelText,
            labelStyle: LabelStyle1,
            contentPadding: EdgeInsets.fromLTRB(25.0, 0.0, 20.0, 10.0),
            enabledBorder: enabledBorder,
            // focusedBorder: enabledBorder,
            errorBorder: errorBorder,
            disabledBorder: enabledBorder,
            focusedErrorBorder: errorBorder,
            enabled: enabled,
          ),
        ),
      ),
    ]);
  }
}
