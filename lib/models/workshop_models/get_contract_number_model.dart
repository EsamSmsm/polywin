// To parse this JSON data, do
//
//     final getContractNumberModel = getContractNumberModelFromJson(jsonString);

import 'dart:convert';

GetContractNumberModel getContractNumberModelFromJson(String str) => GetContractNumberModel.fromJson(json.decode(str));

String getContractNumberModelToJson(GetContractNumberModel data) => json.encode(data.toJson());

class GetContractNumberModel {
  GetContractNumberModel({
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

  factory GetContractNumberModel.fromJson(Map<String, dynamic> json) => GetContractNumberModel(
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
