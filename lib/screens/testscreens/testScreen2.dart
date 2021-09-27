import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class TestScreen2 extends StatefulWidget {
  @override
  _TestScreen2State createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  File? image;
  List<Asset> images = <Asset>[];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to get image:  $e');
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => {pickImage()},
                child: Container(
                  margin: EdgeInsets.only(top: 200),
                  width: 200,
                  height: 200,
                  color: Colors.blueAccent,
                ),
              ),
              Container(
                height: 300,
                width: 300,
                margin: EdgeInsets.only(top: 20),
                child: image != null
                    ? Image.file(image!)
                    : Image.asset('assets/images/avatar.jpg'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
