// To parse this JSON data, do
//
//     final getAllDiscountsModel = getAllDiscountsModelFromJson(jsonString);

import 'dart:convert';

GetAllDiscountsModel getAllDiscountsModelFromJson(String str) => GetAllDiscountsModel.fromJson(json.decode(str));

String getAllDiscountsModelToJson(GetAllDiscountsModel data) => json.encode(data.toJson());

class GetAllDiscountsModel {
  GetAllDiscountsModel({
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

  factory GetAllDiscountsModel.fromJson(Map<String, dynamic> json) => GetAllDiscountsModel(
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
    this.typeOfDescount,
    this.typeOfDescountName,
    this.descount,
    this.typeofCategory,
    this.typeofCategoryName,
    this.typeDescountName,
  });

  int id;
  int typeOfDescount;
  String typeOfDescountName;
  double descount;
  int typeofCategory;
  String typeofCategoryName;
  String typeDescountName;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    typeOfDescount: json["typeOfDescount"],
    typeOfDescountName: json["typeOfDescountName"],
    descount: json["descount"],
    typeofCategory: json["typeofCategory"],
    typeofCategoryName: json["typeofCategoryName"],
    typeDescountName: json["typeDescountName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeOfDescount": typeOfDescount,
    "typeOfDescountName": typeOfDescountName,
    "descount": descount,
    "typeofCategory": typeofCategory,
    "typeofCategoryName": typeofCategoryName,
    "typeDescountName": typeDescountName,
  };
}
