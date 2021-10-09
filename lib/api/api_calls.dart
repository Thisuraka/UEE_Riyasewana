import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'api_caller.dart';
import 'api_response.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

final cloudinary =
    Cloudinary("335379322996961", "dH53tq2_D4rg_VyckVnIbYfui4o", "asqarrsl");

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

  static Future<ApiResponse> signOut({
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;

      return ApiCaller.postRequest('/api/users/logout', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateUser({
    required String token,
    required String id,
    required String fName,
    required String lName,
    required String mobile,
    required String password,
  }) async {
    try {
      var raw = new Map<String, String>();
      raw["first_name"] = fName;
      raw["last_name"] = lName;
      raw["password"] = password;
      raw['mobile'] = mobile;

      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;

      return ApiCaller.postRequest('/api/users/$id',
          data: raw, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  //=================================================================================================

  static Future<ApiResponse> partsAd({
    required String token,
    required String pType,
    required String pCatagory,
    required String pCondition,
    required String pName,
    required String pPrice,
    required String pNegotiate,
    required String pInfo,
    required String pLocation,
    required List<String> pImages,
  }) async {
    try {
      List<String?> urlPhotos = [];

      List<CloudinaryResponse> reply = await cloudinary.uploadFiles(
        filePaths: pImages,
        resourceType: CloudinaryResourceType.auto,
        folder: "UEE",
      );

      reply.forEach((response) {
        if (response.isSuccessful) {
          urlPhotos.add(response.secureUrl);
        }
      });

      var data = new Map<String, String>();
      data['pCatagory'] = pCatagory;
      data['pType'] = pType;
      data["pCondition"] = pCondition;
      data["pName"] = pName;
      data["pPrice"] = pPrice;
      data["pNegotiate"] = pNegotiate;
      data["pInfo"] = pInfo;
      data["pLocation"] = pLocation;
      data["images"] = urlPhotos.map((e) => e).toList().join(',');

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

  static Future<ApiResponse> userPartsGet({
    required String uid,
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/api/parts/user/$uid', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> userPartAdGet({
    required String adID,
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/api/parts/$adID', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> partsUpdate({
    required String token,
    required String adID,
    required String pLocation,
    required String pType,
    required String pCatagory,
    required String pCondition,
    required String pName,
    required String pPrice,
    required String pNegotiate,
    required String pInfo,
    required List<String> vImages,
    List<String>? newImages,
  }) async {
    try {
      List<String?> urlPhotos = [];

      if (vImages.isNotEmpty) {
        vImages.forEach((element) {
          urlPhotos.add(element);
        });
      }
      if (newImages!.isNotEmpty) {
        List<CloudinaryResponse> reply = await cloudinary.uploadFiles(
          filePaths: newImages,
          resourceType: CloudinaryResourceType.auto,
          folder: "UEE",
        );
        reply.forEach((response) {
          if (response.isSuccessful) {
            urlPhotos.add(response.secureUrl);
          }
        });
      }

      var data = new Map<String, String>();
      data['pLocation'] = pLocation;
      data["pType"] = pType;
      data["pCatagory"] = pCatagory;
      data["pCondition"] = pCondition;
      data["pName"] = pName;
      data["pPrice"] = pPrice;
      data["pNegotiate"] = pNegotiate;
      data["pInfo"] = pInfo;

      data["images"] = urlPhotos.map((e) => e).toList().join(',');

      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.putRequest('/api/parts/$adID',
          data: data, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deletePartAd({
    required String adID,
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.deleteRequest('/api/parts/$adID', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  //=================================================================================================

  static Future<ApiResponse> vehiclesAd({
    required String token,
    required String vLocation,
    required String vType,
    required String vBrand,
    required String vCondition,
    required String vModel,
    required String vPrice,
    required String vManf,
    required String vNegotiate,
    required String vTransmission,
    required String vFuel,
    required String vMilage,
    required String vInfo,
    required List<String> vImages,
  }) async {
    try {
      List<String?> urlPhotos = [];
      List<CloudinaryResponse> reply = await cloudinary.uploadFiles(
        filePaths: vImages,
        resourceType: CloudinaryResourceType.auto,
        folder: "UEE",
      );

      reply.forEach((response) {
        if (response.isSuccessful) {
          urlPhotos.add(response.secureUrl);
        }
      });

      var data = new Map<String, String>();
      data['vLocation'] = vLocation;
      data["vType"] = vType;
      data["vBrand"] = vBrand;
      data["vCondition"] = vCondition;
      data["vModel"] = vModel;
      data["vManfYear"] = vManf;
      data["vPrice"] = vPrice;
      data["vNegotiate"] = vNegotiate;
      data["vTransType"] = vTransmission;
      data["vFuelType"] = vFuel;
      data["vMilage"] = vMilage;
      data["vInfo"] = vInfo;
      data["images"] = urlPhotos.map((e) => e).toList().join(',');

      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.postRequest('/api/vehicles',
          data: data, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> userVehiclesGet({
    required String uid,
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/api/vehicles/user/$uid', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> userVehicleAdGet({
    required String adID,
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/api/vehicles/$adID', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> vehiclesUpdate({
    required String token,
    required String adID,
    required String vLocation,
    required String vType,
    required String vBrand,
    required String vCondition,
    required String vModel,
    required String vPrice,
    required String vManf,
    required String vNegotiate,
    required String vTransmission,
    required String vFuel,
    required String vMilage,
    required String vInfo,
    required List<String> vImages,
    List<String>? newImages,
  }) async {
    try {
      List<String?> urlPhotos = [];

      if (vImages.isNotEmpty) {
        vImages.forEach((element) {
          urlPhotos.add(element);
        });
      }
      if (newImages!.isNotEmpty) {
        List<CloudinaryResponse> reply = await cloudinary.uploadFiles(
          filePaths: newImages,
          resourceType: CloudinaryResourceType.auto,
          folder: "UEE",
        );
        reply.forEach((response) {
          if (response.isSuccessful) {
            urlPhotos.add(response.secureUrl);
          }
        });
      }

      var data = new Map<String, String>();
      data['vLocation'] = vLocation;
      data["vType"] = vType;
      data["vBrand"] = vBrand;
      data["vCondition"] = vCondition;
      data["vModel"] = vModel;
      data["vManfYear"] = vManf;
      data["vPrice"] = vPrice;
      data["vNegotiate"] = vNegotiate;
      data["vTransType"] = vTransmission;
      data["vFuelType"] = vFuel;
      data["vMilage"] = vMilage;
      data["vInfo"] = vInfo;
      data["images"] = urlPhotos.map((e) => e).toList().join(',');

      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.putRequest('/api/vehicles/$adID',
          data: data, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteVehicleAd({
    required String adID,
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.deleteRequest('/api/vehicles/$adID', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
