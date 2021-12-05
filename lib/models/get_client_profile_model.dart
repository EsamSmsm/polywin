// To parse this JSON data, do
//
//     final getClientInfoModel = getClientInfoModelFromJson(jsonString);

import 'dart:convert';

GetClientInfoModel getClientInfoModelFromJson(String str) => GetClientInfoModel.fromJson(json.decode(str));

String getClientInfoModelToJson(GetClientInfoModel data) => json.encode(data.toJson());

class GetClientInfoModel {
  GetClientInfoModel({
    this.id,
    this.name,
    this.userType,
    this.clientPhone,
    this.clientAddress,
    this.email,
  });

  int id;
  String name;
  dynamic userType;
  String clientPhone;
  String clientAddress;
  String email;

  factory GetClientInfoModel.fromJson(Map<String, dynamic> json) => GetClientInfoModel(
    id: json["id"],
    name: json["name"],
    userType: json["userType"],
    clientPhone: json["clientPhone"],
    clientAddress: json["clientAddress"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "userType": userType,
    "clientPhone": clientPhone,
    "clientAddress": clientAddress,
    "email": email,
  };
}
