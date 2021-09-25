import 'dart:convert';

PartInfo partInfoFromJson(String str) => PartInfo.fromJson(json.decode(str));

String partInfoToJson(PartInfo data) => json.encode(data.toJson());

class PartInfo {
  List<AdImage> images;
  String pCatagory;
  String pCondition;
  String pName;
  String pPrice;
  bool pNegotiate;
  String pInfo;

  PartInfo(
      {required this.images,
      required this.pCatagory,
      required this.pCondition,
      required this.pName,
      required this.pPrice,
      required this.pNegotiate,
      required this.pInfo});

  factory PartInfo.fromJson(Map<String, dynamic> json) => PartInfo(
        images: json["images"] == null
            ? null
            : json["images"].map((x) => AdImage.fromJson(x)),
        pCatagory: json["pCatagory"] == null ? null : json["pCatagory"],
        pCondition: json["pCondition"] == null ? null : json["pCondition"],
        pName: json["pName"] == null ? null : json["pName"],
        pPrice: json["pPrice"] == null ? null : json["pPrice"],
        pNegotiate: json["pNegotiate"] == null ? null : json["pNegotiate"],
        pInfo: json["pInfo"] == null ? null : json["pInfo"],
      );

  Map<String, dynamic> toJson() => {
        "pCatagory": pCatagory == null ? null : pCatagory,
        "pCondition": pCondition == null ? null : pCondition,
        "pName": pName == null ? null : pName,
        "pPrice": pPrice == null ? null : pPrice,
        "pNegotiate": pNegotiate == null ? null : pNegotiate,
        "pInfo": pInfo == null ? null : pInfo,
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