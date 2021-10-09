import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../styles.dart';

class CustomImagePicker2 extends StatefulWidget {
  final bool gen;
  final List<dynamic>? _cloudImages;

  final Function onChange;

  const CustomImagePicker2(this._cloudImages, this.onChange,
      {Key? key, this.gen = false})
      : super(key: key);

  @override
  _CustomImagePicker2State createState() => _CustomImagePicker2State();
}

class _CustomImagePicker2State extends State<CustomImagePicker2> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile>? _selectedImages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: double.infinity,
            height: 92,
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Button2BorderColor, width: 1.5),
            ),
            child: genList()),
      ],
    ));
  }

  genList() {
    return Container(
      width: double.infinity,
      height: 100,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        childAspectRatio: (100 / 100),
        crossAxisCount: 1,
        children: List.generate(widget._cloudImages!.length, (index) {
          return Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Button2BorderColor)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(widget._cloudImages![index],
                      fit: BoxFit.cover),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onChange(index);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 2, top: 2),
                  child: Image.asset('assets/icons/remove.png',
                      width: 15, height: 15, fit: BoxFit.cover),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
