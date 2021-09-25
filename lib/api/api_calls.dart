import 'dart:convert';
import 'dart:io';
import 'api_caller.dart';
import 'api_response.dart';
import 'package:riyasewana/utils/settings.dart';

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
      raw['email'] = email;
      raw["first_name"] = fName;
      raw["last_name"] = lName;
      raw['mobile'] = mobile;
      raw["password"] = password;

      return ApiCaller.postRequest('/register', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> logIn(String username) async {
    try {
      var formData = new Map<String, dynamic>();
      formData['email'] = 'email';
      formData['password'] = 'password';
      Map<String, String> headers = new Map();
      headers["Accept"] = "*/*";
      return ApiCaller.postRequest('/login', data: formData, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
