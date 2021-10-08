import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'api_response.dart';
import 'api_status.dart';
import 'package:dio/dio.dart';

// const baseUrl = "http://localhost:4001";
const baseUrl = "http://10.0.2.2:4001";
const timeout = 80;

class ApiCaller {
  static Future<ApiResponse> postRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();
        allHeaders["Accept"] = "application/json";
        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);
        // print(data);

        final response = await http
            .post(
              Uri.parse(baseUrl + endpoint),
              headers: allHeaders,
              body: data,
            )
            .timeout(const Duration(seconds: timeout));

        print(response.statusCode.toString() + "  Response: " + response.body);
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse(response: null);
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      print(response.toString());
      return response;
    }
  }

  static Future<ApiResponse> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();

        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);
        final response = await http
            .get(Uri.parse(baseUrl + endpoint), headers: headers)
            .timeout(const Duration(seconds: timeout));
        print(response.statusCode.toString() + "  Response: " + response.body);

        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      return response;
    }
  }

  static Future<ApiResponse> multiPartRequest(String endpoint,
      {Map<String, String>? data,
      List<MultipartFile>? files,
      Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();
        allHeaders["Accept"] = "application/json";
        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);

        final request = http.MultipartRequest(
          "POST",
          Uri.parse(baseUrl + endpoint),
        );
        request.headers.addAll(allHeaders);
        request.fields.addAll(data!);
        // request.files.addAll(files!);

        final response = await http.Response.fromStream(await request.send())
            .timeout(const Duration(seconds: timeout));
        print('response ' + response.statusCode.toString());

        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse(response: null);
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      print("got here");
      print(response.toString());
      return response;
    }
  }
}
