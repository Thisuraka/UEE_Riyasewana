import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../styles.dart';

class CustomDropDown extends StatefulWidget {
  String hint, itemValue;
  List<String> itemList;
  final ValueSetter<String>? newValue;
  String? Function(dynamic)? validator;

  CustomDropDown(
      {Key? key,
      this.validator,
      required this.itemValue,
      required this.itemList,
      required this.hint,
      this.newValue})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  static InputBorder errorBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red));

  static InputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFA5A5A5),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownSearch<String>(
        mode: Mode.MENU,
        showSearchBox: true,
        items: widget.itemList,
        validator: widget.validator,
        onChanged: (value) => widget.newValue!(value!),
        selectedItem: widget.itemValue,
        dropdownSearchDecoration: InputDecoration(
          labelText: widget.hint,
          hintText: widget.hint,
          focusedBorder: enabledBorder,
          enabledBorder: enabledBorder,
          errorBorder: errorBorder,
          contentPadding:
              EdgeInsets.only(left: 20, right: 10, top: 0.0, bottom: 0.0),
        ),
      ),
    );
  }
}
