// To parse this JSON data, do
//
//     final getColorsModel = getColorsModelFromJson(jsonString);

import 'dart:convert';

GetColorsModel getColorsModelFromJson(String str) => GetColorsModel.fromJson(json.decode(str));

String getColorsModelToJson(GetColorsModel data) => json.encode(data.toJson());

class GetColorsModel {
  GetColorsModel({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  List<Payload> payload;
  bool isSuccess;

  factory GetColorsModel.fromJson(Map<String, dynamic> json) => GetColorsModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    payload: List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    "isSuccess": isSuccess,
  };
}

class Payload {
  Payload({
    this.id,
    this.colorName,
  });

  int id;
  String colorName;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    colorName: json["colorName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "colorName": colorName,
  };
}
