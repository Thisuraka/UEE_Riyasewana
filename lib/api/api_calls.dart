import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'api_caller.dart';
import 'api_response.dart';
// import 'package:dio/dio.dart';

class ApiCalls {
  static Future<ApiResponse> signUp({
    required String email,
    required String fName,
    required String lName,
    required String mobile,
    required String password,
  }) async {
    try {
      var raw = new Map<String, String>();
      raw["first_name"] = fName;
      raw["last_name"] = lName;
      raw['email'] = email;
      raw["password"] = password;
      raw['mobile'] = mobile;

      return ApiCaller.postRequest('/api/users/register', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var raw = new Map<String, String>();
      raw['email'] = email;
      raw["password"] = password;

      print(raw['email']);
      print(raw["password"]);

      return ApiCaller.postRequest('/api/users/login', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> partsAd({
    required String token,
    required String pCatagory,
    required String pCondition,
    required String pName,
    required String pPrice,
    required String pNegotiate,
    required String pInfo,
    required String pLocation,
    required List<XFile>? pImages,
  }) async {
    try {
      var data = new Map<String, String>();
      data['pCatagory'] = pCatagory;
      data["pCondition"] = pCondition;
      data["pName"] = pName;
      data["pPrice"] = pPrice;
      data["pNegotiate"] = pNegotiate;
      data["pInfo"] = pInfo;
      data["pLocation"] = pLocation;
      // data["image"] = pImages!.map((e) => e.path).toList().join(', ');

      List<MultipartFile>? files = [];
      if (pImages != null && pImages.length > 0) {
        for (var i = 0; i < pImages.length; i++) {
          final length = await pImages[i].length();
          MediaType mediaType = new MediaType('image', 'jpeg');
          var filePart = http.MultipartFile(
              'image' + (i + 1).toString(), pImages[i].openRead(), length,
              contentType: mediaType, filename: '$i' + '.jpg');
          files.add(filePart);
        }
      }

      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.postRequest('/api/parts', data: data, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
