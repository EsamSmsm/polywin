// To parse this JSON data, do
//
//     final clientTypeDetailsModel = clientTypeDetailsModelFromJson(jsonString);

import 'dart:convert';

ClientTypeDetailsModel clientTypeDetailsModelFromJson(String str) =>
    ClientTypeDetailsModel.fromJson(json.decode(str));

String clientTypeDetailsModelToJson(ClientTypeDetailsModel data) =>
    json.encode(data.toJson());

class ClientTypeDetailsModel {
  ClientTypeDetailsModel({
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

  factory ClientTypeDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClientTypeDetailsModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        payload:
            List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
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
    this.parentName,
    this.clientLogo,
    this.userType,
    this.clientPhone,
    this.long,
    this.late,
    this.clientAddress,
    this.email,
  });

  int id;
  String name;
  String parentName;
  String clientLogo;
  String userType;
  String clientPhone;
  dynamic long;
  dynamic late;
  String clientAddress;
  String email;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        name: json["name"],
        parentName: json["parentName"],
        clientLogo: json["clientLogo"],
        userType: json["userType"],
        clientPhone: json["clientPhone"],
        long: json["long"],
        late: json["late"],
        clientAddress: json["clientAddress"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parentName": parentName,
        "clientLogo": clientLogo,
        "userType": userType,
        "clientPhone": clientPhone,
        "long": long,
        "late": late,
        "clientAddress": clientAddress,
        "email": email,
      };
}
