import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../styles.dart';

class CustomImagePicker extends StatefulWidget {
  final bool gen;
  final List<XFile>? _imageFileList;
  final Function onTap;
  final Function onChange;

  const CustomImagePicker(this._imageFileList, this.onTap, this.onChange,
      {Key? key, this.gen = false})
      : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
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
        GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            width: widget.gen ? 95 : double.infinity,
            height: 92,
            margin: EdgeInsets.only(right: 20, left: 20),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.gen ? 15 : 50),
              border: Border.all(color: Button2BorderColor, width: 1.5),
            ),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/icons/addImage.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Text("Add images"),
                ),
              ],
            ),
          ),
        ),
        widget.gen ? genList() : Container()
      ],
    ));
  }

  genList() {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.only(left: 125),
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        childAspectRatio: (100 / 100),
        crossAxisCount: 1,
        children: List.generate(widget._imageFileList!.length, (index) {
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
                  child: Image.file(File(widget._imageFileList![index].path),
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
