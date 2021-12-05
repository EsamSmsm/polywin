// To parse this JSON data, do
//
//     final getClientTypeCountModel = getClientTypeCountModelFromJson(jsonString);

import 'dart:convert';

GetClientTypeCountModel getClientTypeCountModelFromJson(String str) => GetClientTypeCountModel.fromJson(json.decode(str));

String getClientTypeCountModelToJson(GetClientTypeCountModel data) => json.encode(data.toJson());

class GetClientTypeCountModel {
  GetClientTypeCountModel({
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

  factory GetClientTypeCountModel.fromJson(Map<String, dynamic> json) => GetClientTypeCountModel(
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
    this.clientType,
    this.count,
  });

  int id;
  String clientType;
  int count;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    clientType: json["clientType"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clientType": clientType,
    "count": count,
  };
}
