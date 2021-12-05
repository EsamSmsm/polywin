// To parse this JSON data, do
//
//     final getUserInfo = getUserInfoFromJson(jsonString);

import 'dart:convert';

GetUserInfoModel getUserInfoFromJson(String str) => GetUserInfoModel.fromJson(json.decode(str));

String getUserInfoToJson(GetUserInfoModel data) => json.encode(data.toJson());

class GetUserInfoModel {
  GetUserInfoModel({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  Payload payload;
  bool isSuccess;

  factory GetUserInfoModel.fromJson(Map<String, dynamic> json) => GetUserInfoModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    payload: Payload.fromJson(json["payload"]),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "payload": payload.toJson(),
    "isSuccess": isSuccess,
  };
}

class Payload {
  Payload({
    this.id,
    this.name,
    this.nameAgent,
    this.agentLogo,
    this.agentGovernorate,
    this.agentAddress,
    this.agentPhone,
    this.userId,
    this.email,
    this.long,
    this.late,
  });

  int id;
  String name;
  String nameAgent;
  String agentLogo;
  String agentGovernorate;
  String agentAddress;
  String agentPhone;
  dynamic userId;
  dynamic email;
  dynamic long;
  dynamic late;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    name: json["name"],
    nameAgent: json["nameAgent"],
    agentLogo: json["agentLogo"],
    agentGovernorate: json["agentGovernorate"],
    agentAddress: json["agentAddress"],
    agentPhone: json["agentPhone"],
    userId: json["userId"],
    email: json["email"],
    long: json["long"],
    late: json["late"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nameAgent": nameAgent,
    "agentLogo": agentLogo,
    "agentGovernorate": agentGovernorate,
    "agentAddress": agentAddress,
    "agentPhone": agentPhone,
    "userId": userId,
    "email": email,
    "long": long,
    "late": late,
  };
}
