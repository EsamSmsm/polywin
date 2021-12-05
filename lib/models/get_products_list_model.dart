// To parse this JSON data, do
//
//     final getProductsListModel = getProductsListModelFromJson(jsonString);

import 'dart:convert';

ProductsListModel getProductsListModelFromJson(String str) =>
    ProductsListModel.fromJson(json.decode(str));

String getProductsListModelToJson(ProductsListModel data) =>
    json.encode(data.toJson());

class ProductsListModel {
  ProductsListModel({
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

  factory ProductsListModel.fromJson(Map<String, dynamic> json) =>
      ProductsListModel(
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
    this.categoryName,
    this.listProduct,
  });

  String categoryName;
  List<ListProduct> listProduct;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        categoryName: json["categoryName"],
        listProduct: List<ListProduct>.from(
            json["listProduct"].map((x) => ListProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "listProduct": List<dynamic>.from(listProduct.map((x) => x.toJson())),
      };
}

class ListProduct {
  ListProduct({
    this.id,
    this.productCode,
    this.categoryId,
    this.categoryName,
    this.pricePerOne,
    this.name,
    this.imgUrl,
    this.totalQuota,
    this.measruingUnit,
    this.pricePerMeter,
    this.photo,
    this.typeOfCategory,
    this.numberIron,
  });

  int id;
  String productCode;
  int categoryId;
  dynamic categoryName;
  double pricePerOne;
  String name;
  String imgUrl;
  dynamic totalQuota;
  String measruingUnit;
  double pricePerMeter;
  dynamic photo;
  dynamic typeOfCategory;
  int numberIron;

  factory ListProduct.fromJson(Map<String, dynamic> json) => ListProduct(
        id: json["id"],
        productCode: json["productCode"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        pricePerOne: json["pricePerOne"].toDouble(),
        name: json["name"],
        imgUrl: json["imgURL"],
        totalQuota: json["totalQuota"],
        measruingUnit: json["measruingUnit"],
        pricePerMeter: json["pricePerMeter"].toDouble(),
        photo: json["photo"],
        typeOfCategory: json["typeOfCategory"],
        numberIron: json["numberIron"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productCode": productCode,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "pricePerOne": pricePerOne,
        "name": name,
        "imgURL": imgUrl,
        "totalQuota": totalQuota,
        "measruingUnit": measruingUnit,
        "pricePerMeter": pricePerMeter,
        "photo": photo,
        "typeOfCategory": typeOfCategory,
        "numberIron": numberIron,
      };
}
