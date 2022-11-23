// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.status,
    required this.user,
    required this.hospitalInfo,
    required this.token,
  });

  int status;
  User user;
  HospitalInfo hospitalInfo;
  String token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json["status"],
    user: User.fromJson(json["user"]),
    hospitalInfo: HospitalInfo.fromJson(json["hospitalInfo"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
    "hospitalInfo": hospitalInfo.toJson(),
    "token": token,
  };
}

class HospitalInfo {
  HospitalInfo({
    required this.id,
    required this.name,
    this.tagLine,
    this.logo,
    required this.fullAddress,
  });

  int id;
  String name;
  dynamic tagLine;
  dynamic logo;
  String fullAddress;

  factory HospitalInfo.fromJson(Map<String, dynamic> json) => HospitalInfo(
    id: json["id"],
    name: json["name"],
    tagLine: json["tag_line"],
    logo: json["logo"],
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tag_line": tagLine,
    "logo": logo,
    "full_address": fullAddress,
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhotoPath,
    required this.profilePhotoUrl,
  });

  int id;
  String name;
  String email;
  dynamic profilePhotoPath;
  String profilePhotoUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    profilePhotoPath: json["profile_photo_path"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "profile_photo_path": profilePhotoPath,
    "profile_photo_url": profilePhotoUrl,
  };
}
