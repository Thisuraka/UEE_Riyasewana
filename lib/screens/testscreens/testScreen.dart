import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styles.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 20),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(top: 200),
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              childAspectRatio: (100 / 100),
              crossAxisCount: 1,
              children: List.generate(_imageFileList!.length, (index) {
                return Container(
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
                );
              }),
            ),
          ),
        ],
      ),
    ));
  }

  void selectImages() async {
    final List<XFile>? _selectedImages = await _picker.pickMultiImage();
    if (_selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(_selectedImages);
    }
    print("Image list length : " + _imageFileList!.length.toString());
    setState(() {});
  }
}



          // Container(
          //   width: double.infinity,
          //   height: 100,
          //   child: GridView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: _imageFileList!.length,
          //     gridDelegate:
          //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         height: 20,
          //         width: 20,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             border: Border.all(color: Button2BorderColor)),
          //         child: Image.file(File(_imageFileList![index].path),
          //             fit: BoxFit.cover),
          //       );
          //     },
          //   ),
          // )