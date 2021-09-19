import 'package:flutter/material.dart';

import '../../styles.dart';

class CustomDropDown extends StatefulWidget {
  String hint, itemValue;
  List<String> itemList;
  Function(String value) onSelectionChange;

  CustomDropDown({
    Key? key,
    required this.itemValue,
    required this.itemList,
    required this.hint,
    required this.onSelectionChange,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late InputBorder enabledBorder;

  @override
  void initState() {
    enabledBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 0.5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
      height: 52.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelStyle: HintStyle1,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.hint,
          border: enabledBorder,
          contentPadding:
              EdgeInsets.only(bottom: 20.0, left: 25.0, right: 10.0, top: 10.0),
        ),
        items: widget.itemList.map((String category) {
          return new DropdownMenuItem(
              value: category,
              child: Text(
                category,
                style: TextStyle(fontSize: 14.0),
              ));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            widget.itemValue = newValue as String;
          });
        },
      ),
    );
  }
}
