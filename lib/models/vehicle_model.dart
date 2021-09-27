import 'dart:convert';

import 'package:image_picker/image_picker.dart';

VehicleInfo vehicleInfoFromJson(String str) =>
    VehicleInfo.fromJson(json.decode(str));

String vehicleInfoToJson(VehicleInfo data) => json.encode(data.toJson());

class VehicleInfo {
  List<XFile>? images;
  String vType;
  String vBrand;
  String vCondition;
  String vModel;
  String vManfYear;
  String vPrice;
  bool vNegotiate;
  String vTransType;
  String vFuelType;
  String vMilage;
  String vInfo;

  VehicleInfo(
      {required this.images,
      required this.vType,
      required this.vBrand,
      required this.vCondition,
      required this.vModel,
      required this.vManfYear,
      required this.vPrice,
      required this.vNegotiate,
      required this.vTransType,
      required this.vFuelType,
      required this.vMilage,
      required this.vInfo});

  factory VehicleInfo.fromJson(Map<String, dynamic> json) => VehicleInfo(
        images: json["images"] == null
            ? null
            : json["images"].map((x) => AdImage.fromJson(x)),
        vType: json["vType"] == null ? null : json["vType"],
        vBrand: json["vBrand"] == null ? null : json["vBrand"],
        vCondition: json["vCondition"] == null ? null : json["vCondition"],
        vModel: json["vModel"] == null ? null : json["vModel"],
        vManfYear: json["vManfYear"] == null ? null : json["vManfYear"],
        vPrice: json["vPrice"] == null ? null : json["vPrice"],
        vNegotiate: json["vNegotiate"] == null ? null : json["vNegotiate"],
        vTransType: json["vTransType"] == null ? null : json["vTransType"],
        vFuelType: json["vFuelType"] == null ? null : json["vFuelType"],
        vMilage: json["vMilage"] == null ? null : json["vMilage"],
        vInfo: json["vInfo"] == null ? null : json["vInfo"],
      );

  Map<String, dynamic> toJson() => {
        "vType": vType == null ? null : vType,
        "vBrand": vBrand == null ? null : vBrand,
        "vCondition": vCondition == null ? null : vCondition,
        "vModel": vModel == null ? null : vModel,
        "vManfYear": vManfYear == null ? null : vManfYear,
        "vPrice": vPrice == null ? null : vPrice,
        "vNegotiate": vNegotiate == null ? null : vNegotiate,
        "vTransType": vTransType == null ? null : vTransType,
        "vFuelType": vFuelType == null ? null : vFuelType,
        "vMilage": vMilage == null ? null : vMilage,
        "vInfo": vInfo == null ? null : vInfo,
      };
}

class AdImage {
  String url;
  AdImage({required this.url});
  factory AdImage.fromJson(Map<String, dynamic> json) => AdImage(
        url: json["url"],
      );
}


  // images: json["images"] == null ? null : List<AdImage>.from(json["images"].map((x) => AdImage.fromJson(x))),