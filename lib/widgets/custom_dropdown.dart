import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../styles.dart';

class CustomDropDown extends StatefulWidget {
  String hint, itemValue;
  List<String> itemList;
  final ValueSetter<String>? newValue;

  CustomDropDown(
      {Key? key,
      required this.itemValue,
      required this.itemList,
      required this.hint,
      this.newValue})
      : super(key: key);

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
      child: DropdownSearch<String>(
        mode: Mode.MENU,
        showSearchBox: true,
        items: widget.itemList,
        label: widget.hint,
        hint: widget.hint,
        onChanged: (value) => widget.newValue!(value!),
        selectedItem: widget.itemValue,
        // dropdownSearchDecoration: InputDecoration(),
      ),
    );
  }
}
