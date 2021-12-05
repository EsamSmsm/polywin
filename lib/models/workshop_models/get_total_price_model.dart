// To parse this JSON data, do
//
//     final getTotalPriceModel = getTotalPriceModelFromJson(jsonString);

import 'dart:convert';

GetTotalPriceModel getTotalPriceModelFromJson(String str) =>
    GetTotalPriceModel.fromJson(json.decode(str));

String getTotalPriceModelToJson(GetTotalPriceModel data) =>
    json.encode(data.toJson());

class GetTotalPriceModel {
  GetTotalPriceModel({
    this.costCalcId,
    this.totalExpenses,
    this.totalMortal,
    this.totalCost,
    this.net,
    this.items,
  });

  int costCalcId;
  dynamic totalExpenses;
  dynamic totalMortal;
  dynamic totalCost;
  dynamic net;
  List<Item> items;

  factory GetTotalPriceModel.fromJson(Map<String, dynamic> json) =>
      GetTotalPriceModel(
        costCalcId: json["costCalcId"],
        totalExpenses: json["totalExpenses"],
        totalMortal: json["totalMortal"],
        totalCost: json["totalCost"],
        net: json["net"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "costCalcId": costCalcId,
        "totalExpenses": totalExpenses,
        "totalMortal": totalMortal,
        "totalCost": totalCost,
        "net": net,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.productId,
    this.productName,
    this.meter,
    this.cost,
    this.totalMeterCost,
    this.descount,
    this.typeOfDescount,
    this.totalByDescount,
  });

  int productId;
  String productName;
  String meter;
  String cost;
  String totalMeterCost;
  String descount;
  String typeOfDescount;
  String totalByDescount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"],
        productName: json["productName"],
        meter: json["meter"],
        cost: json["cost"],
        totalMeterCost: json["totalMeterCost"],
        descount: json["descount"],
        typeOfDescount: json["typeOfDescount"],
        totalByDescount: json["totalByDescount"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "meter": meter,
        "cost": cost,
        "totalMeterCost": totalMeterCost,
        "descount": descount,
        "typeOfDescount": typeOfDescount,
        "totalByDescount": totalByDescount,
      };
}
