// To parse this JSON data, do
//
//     final getAllClientsModel = getAllClientsModelFromJson(jsonString);

import 'dart:convert';

GetAllClientsModel getAllClientsModelFromJson(String str) => GetAllClientsModel.fromJson(json.decode(str));

String getAllClientsModelToJson(GetAllClientsModel data) => json.encode(data.toJson());

class GetAllClientsModel {
  GetAllClientsModel({
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

  factory GetAllClientsModel.fromJson(Map<String, dynamic> json) => GetAllClientsModel(
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
    this.clientAddress,
    this.clientPhone,
    this.email,
  });

  int id;
  String name;
  String clientAddress;
  String clientPhone;
  String email;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    name: json["name"],
    clientAddress: json["clientAddress"],
    clientPhone: json["clientPhone"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "clientAddress": clientAddress,
    "clientPhone": clientPhone,
    "email": email == null ? null : email,
  };
}
