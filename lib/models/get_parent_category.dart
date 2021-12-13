// To parse this JSON data, do
//
//     final getParentCategory = getParentCategoryFromJson(jsonString);

import 'dart:convert';

GetParentCategoryModel getParentCategoryFromJson(String str) =>
    GetParentCategoryModel.fromJson(json.decode(str));

String getParentCategoryToJson(GetParentCategoryModel data) =>
    json.encode(data.toJson());

class GetParentCategoryModel {
  GetParentCategoryModel({
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

  factory GetParentCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetParentCategoryModel(
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
    this.parentCategory,
    this.haveIron,
    this.listCategory,
  });

  int id;
  String parentCategory;
  var haveIron;
  List<ListCategory> listCategory;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        parentCategory: json["parentCategory"],
        haveIron: json["haveIron"],
        listCategory: List<ListCategory>.from(
            json["listCategory"].map((x) => ListCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentCategory": parentCategory,
        "haveIron": haveIron,
        "listCategory": List<dynamic>.from(listCategory.map((x) => x.toJson())),
      };
}

class ListCategory {
  ListCategory({
    this.id,
    this.categoryName,
    this.typeOfCategoryName,
    this.typeOfCategoryId,
    this.products,
  });

  int id;
  String categoryName;
  dynamic typeOfCategoryName;
  dynamic typeOfCategoryId;
  List<Product> products;

  factory ListCategory.fromJson(Map<String, dynamic> json) => ListCategory(
        id: json["id"],
        categoryName: json["categoryName"],
        typeOfCategoryName: json["typeOfCategoryName"],
        typeOfCategoryId: json["typeOfCategoryId"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
        "typeOfCategoryName": typeOfCategoryName,
        "typeOfCategoryId": typeOfCategoryId,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.colorId,
    this.colorName,
    this.productCode,
    this.categoryId,
    this.categoryName,
    this.pricePerOne,
    this.name,
    this.imgUrl,
    this.totalQuota,
    this.measruingUnit,
    this.pricePerMeter,
    this.fileUpload,
    this.numberIron,
    this.descount,
    this.typeOfCategory,
    this.productId,
    this.productName,
    this.listProductIngredients,
    this.listDtoProductIngredientAccessory,
  });

  int id;
  int colorId;
  String colorName;
  String productCode;
  int categoryId;
  String categoryName;
  double pricePerOne;
  String name;
  String imgUrl;
  int totalQuota;
  String measruingUnit;
  double pricePerMeter;
  dynamic fileUpload;
  int numberIron;
  double descount;
  int typeOfCategory;
  int productId;
  String productName;
  dynamic listProductIngredients;
  dynamic listDtoProductIngredientAccessory;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        colorId: json["colorId"],
        colorName: json["colorName"],
        productCode: json["productCode"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        pricePerOne: json["pricePerOne"],
        name: json["name"],
        imgUrl: json["imgURL"],
        totalQuota: json["totalQuota"],
        measruingUnit: json["measruingUnit"],
        pricePerMeter: json["pricePerMeter"],
        fileUpload: json["fileUpload"],
        numberIron: json["numberIron"],
        descount: json["descount"],
        typeOfCategory: json["typeOfCategory"],
        productId: json["productId"],
        productName: json["productName"],
        listProductIngredients: json["listProductIngredients"],
        listDtoProductIngredientAccessory:
            json["listDtoProductIngredientAccessory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "colorId": colorId,
        "colorName": colorName,
        "productCode": productCode,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "pricePerOne": pricePerOne,
        "name": name,
        "imgURL": imgUrl,
        "totalQuota": totalQuota,
        "measruingUnit": measruingUnit,
        "pricePerMeter": pricePerMeter,
        "fileUpload": fileUpload,
        "numberIron": numberIron,
        "descount": descount,
        "typeOfCategory": typeOfCategory,
        "productId": productId,
        "productName": productName,
        "listProductIngredients": listProductIngredients,
        "listDtoProductIngredientAccessory": listDtoProductIngredientAccessory,
      };
}
