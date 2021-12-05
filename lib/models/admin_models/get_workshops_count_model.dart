// To parse this JSON data, do
//
//     final getWorkshopsCountModel = getWorkshopsCountModelFromJson(jsonString);

import 'dart:convert';

GetWorkshopsCountModel getWorkshopsCountModelFromJson(String str) => GetWorkshopsCountModel.fromJson(json.decode(str));

String getWorkshopsCountModelToJson(GetWorkshopsCountModel data) => json.encode(data.toJson());

class GetWorkshopsCountModel {
  GetWorkshopsCountModel({
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

  factory GetWorkshopsCountModel.fromJson(Map<String, dynamic> json) => GetWorkshopsCountModel(
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
