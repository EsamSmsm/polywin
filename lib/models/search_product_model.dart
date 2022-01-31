// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

SearchProductModel searchProductModelFromJson(String str) =>
    SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) =>
    json.encode(data.toJson());

class SearchProductModel {
  SearchProductModel({
    this.result,
    this.id,
    this.exception,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.isCompletedSuccessfully,
    this.creationOptions,
    this.asyncState,
    this.isFaulted,
  });

  Result result;
  int id;
  dynamic exception;
  int status;
  bool isCanceled;
  bool isCompleted;
  bool isCompletedSuccessfully;
  int creationOptions;
  dynamic asyncState;
  bool isFaulted;

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        result: Result.fromJson(json["result"]),
        id: json["id"],
        exception: json["exception"],
        status: json["status"],
        isCanceled: json["isCanceled"],
        isCompleted: json["isCompleted"],
        isCompletedSuccessfully: json["isCompletedSuccessfully"],
        creationOptions: json["creationOptions"],
        asyncState: json["asyncState"],
        isFaulted: json["isFaulted"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "id": id,
        "exception": exception,
        "status": status,
        "isCanceled": isCanceled,
        "isCompleted": isCompleted,
        "isCompletedSuccessfully": isCompletedSuccessfully,
        "creationOptions": creationOptions,
        "asyncState": asyncState,
        "isFaulted": isFaulted,
      };
}

class Result {
  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    this.numberIron,
    this.descount,
    this.typeOfCategory,
  });

  int id;
  String productCode;
  int categoryId;
  String categoryName;
  double pricePerOne;
  String name;
  String imgUrl;
  int totalQuota;
  String measruingUnit;
  double pricePerMeter;
  dynamic photo;
  int numberIron;
  dynamic descount;
  dynamic typeOfCategory;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
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
        numberIron: json["numberIron"],
        descount: json["descount"] ?? 0,
        typeOfCategory: json["typeOfCategory"],
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
        "numberIron": numberIron,
        "descount": descount,
        "typeOfCategory": typeOfCategory,
      };
}
