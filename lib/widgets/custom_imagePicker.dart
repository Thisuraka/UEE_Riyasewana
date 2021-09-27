import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../styles.dart';

class CustomImagePicker extends StatefulWidget {
  List<XFile>? imageFileList = [];

  CustomImagePicker({
    Key? key,
    required this.imageFileList,
  }) : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  final List<XFile>? _selectedImages = [];
  double _size = double.infinity;
  double _radius = 50;
  bool _gen = false;

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
            selectImages();
            updateSizeSmall();
          },
          child: Container(
            width: _size,
            height: 92,
            margin: EdgeInsets.only(right: 20, left: 20),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_radius),
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
        _gen ? genList() : Container()
      ],
    ));
  }

  void updateSizeSmall() {
    setState(() {
      _size = 95;
      _radius = 15;
    });
  }

  void selectImages() async {
    final List<XFile>? _selectedImages = await _picker.pickMultiImage();
    if (_selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(_selectedImages);
      if (_imageFileList!.length > 9) {
        int l = _imageFileList!.length;
        _imageFileList!.removeRange(9, l);
        print("Sorry can't have more than 9");
      }
    }
    print("Image list length : " + _imageFileList!.length.toString());
    _gen = true;
    setState(() {});
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
        children: List.generate(_imageFileList!.length, (index) {
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
                  child: Image.file(File(_imageFileList![index].path),
                      fit: BoxFit.cover),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print(index);
                    _imageFileList!.removeAt(index);
                    if (_imageFileList!.length < 1) {
                      selectImages();
                    }
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
