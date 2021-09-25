import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen2 extends StatefulWidget {
  @override
  _TestScreen2State createState() => _TestScreen2State();
}

final ImagePicker _picker = ImagePicker();

class _TestScreen2State extends State<TestScreen2> {
  final Future<XFile?> image = _picker.pickImage(source: ImageSource.gallery);
  final Future<XFile?> photo = _picker.pickImage(source: ImageSource.camera);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        // onTap: ,
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blueAccent,
        ),
      ),
    ));
  }
}
