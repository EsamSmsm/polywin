// To parse this JSON data, do
//
//     final storeDataModel = storeDataModelFromJson(jsonString);

import 'dart:convert';

StoreDataModel storeDataModelFromJson(String str) => StoreDataModel.fromJson(json.decode(str));

String storeDataModelToJson(StoreDataModel data) => json.encode(data.toJson());

class StoreDataModel {
  StoreDataModel({
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

  factory StoreDataModel.fromJson(Map<String, dynamic> json) => StoreDataModel(
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
    this.categoryName,
    this.listProduct,
  });

  String categoryName;
  List<ListProduct> listProduct;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    categoryName: json["categoryName"],
    listProduct: List<ListProduct>.from(json["listProduct"].map((x) => ListProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "listProduct": List<dynamic>.from(listProduct.map((x) => x.toJson())),
  };
}

class ListProduct {
  ListProduct({
    this.id,
    this.categoryName,
    this.productId,
    this.productName,
    this.productImg,
    this.totalPriceProduct,
    this.quantity,
    this.productCode,
    this.measruingUnit,
    this.pricePerMeter,
    this.pricePerOne,
  });

  int id;
  dynamic categoryName;
  int productId;
  String productName;
  String productImg;
  double totalPriceProduct;
  int quantity;
  String productCode;
  dynamic measruingUnit;
  double pricePerMeter;
  double pricePerOne;

  factory ListProduct.fromJson(Map<String, dynamic> json) => ListProduct(
    id: json["id"],
    categoryName: json["categoryName"],
    productId: json["productId"],
    productName: json["productName"],
    productImg: json["productImg"],
    totalPriceProduct: json["totalPriceProduct"].toDouble(),
    quantity: json["quantity"],
    productCode: json["productCode"],
    measruingUnit: json["measruingUnit"],
    pricePerMeter: json["pricePerMeter"].toDouble(),
    pricePerOne: json["pricePerOne"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "productId": productId,
    "productName": productName,
    "productImg": productImg,
    "totalPriceProduct": totalPriceProduct,
    "quantity": quantity,
    "productCode": productCode,
    "measruingUnit": measruingUnit,
    "pricePerMeter": pricePerMeter,
    "pricePerOne": pricePerOne,
  };
}
