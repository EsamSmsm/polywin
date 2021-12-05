// To parse this JSON data, do
//
//     final getWorkShopProductsModel = getWorkShopProductsModelFromJson(jsonString);

import 'dart:convert';

GetWorkShopProductsModel getWorkShopProductsModelFromJson(String str) => GetWorkShopProductsModel.fromJson(json.decode(str));

String getWorkShopProductsModelToJson(GetWorkShopProductsModel data) => json.encode(data.toJson());

class GetWorkShopProductsModel {
  GetWorkShopProductsModel({
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

  factory GetWorkShopProductsModel.fromJson(Map<String, dynamic> json) => GetWorkShopProductsModel(
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
    this.parentCategory,
    this.listSub,
  });

  int id;
  String parentCategory;
  List<ListSub> listSub;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    parentCategory: json["parentCategory"],
    listSub: List<ListSub>.from(json["listSub"].map((x) => ListSub.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parentCategory": parentCategory,
    "listSub": List<dynamic>.from(listSub.map((x) => x.toJson())),
  };
}

class ListSub {
  ListSub({
    this.id,
    this.subCategory,
    this.filePath,
  });

  int id;
  String subCategory;
  String filePath;

  factory ListSub.fromJson(Map<String, dynamic> json) => ListSub(
    id: json["id"],
    subCategory: json["subCategory"],
    filePath: json["filePath"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subCategory": subCategory,
    "filePath": filePath,
  };
}
