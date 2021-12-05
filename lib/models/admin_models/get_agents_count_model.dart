// To parse this JSON data, do
//
//     final getAgentsCount = getAgentsCountFromJson(jsonString);

import 'dart:convert';

GetAgentsCountModel getAgentsCountFromJson(String str) => GetAgentsCountModel.fromJson(json.decode(str));

String getAgentsCountToJson(GetAgentsCountModel data) => json.encode(data.toJson());

class GetAgentsCountModel {
  GetAgentsCountModel({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  int payload;
  bool isSuccess;

  factory GetAgentsCountModel.fromJson(Map<String, dynamic> json) => GetAgentsCountModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    payload: json["payload"],
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "payload": payload,
    "isSuccess": isSuccess,
  };
}
