import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  String email;
  String fName;
  String lName;
  String mobile;
  String password;
  String token;

  UserInfo(
      {required this.email,
      required this.fName,
      required this.lName,
      required this.mobile,
      required this.password,
      required this.token});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        email: json["email"] == null ? null : json["email"],
        fName: json["fName"] == null ? null : json["fName"],
        lName: json["lName"] == null ? null : json["lName"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        password: json["password"] == null ? null : json["password"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "fName": fName == null ? null : fName,
        "lName": lName == null ? null : lName,
        "mobile": mobile == null ? null : mobile,
        "password": password == null ? null : password,
        "token": token == null ? null : token,
      };
}
