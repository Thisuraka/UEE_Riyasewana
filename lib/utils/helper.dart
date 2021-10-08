import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Helper {
  static Future<List<XFile>> selectImages() async {
    final List<XFile>? _imageFileList = [];
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? _selectedImages = await _picker.pickMultiImage();
    if (_selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(_selectedImages);
      if (_imageFileList.length > 9) {
        int l = _imageFileList.length;
        _imageFileList.removeRange(9, l);
        print("Sorry can't have more than 9");
      }
    }
    print("Image list length : " + _imageFileList!.length.toString());
    return _imageFileList;
  }
}
