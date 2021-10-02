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

      return ApiCaller.postRequest('/api/users/login', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
