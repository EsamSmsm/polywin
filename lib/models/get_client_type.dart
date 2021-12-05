// To parse this JSON data, do
//
//     final getClientType = getClientTypeFromJson(jsonString);

import 'dart:convert';

GetClientType getClientTypeFromJson(String str) => GetClientType.fromJson(json.decode(str));

String getClientTypeToJson(GetClientType data) => json.encode(data.toJson());

class GetClientType {
  GetClientType({
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

  factory GetClientType.fromJson(Map<String, dynamic> json) => GetClientType(
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
    this.name,
  });

  int id;
  String name;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
