// To parse this JSON data, do
//
//     final getCostByClientIdModel = getCostByClientIdModelFromJson(jsonString);

import 'dart:convert';

GetCostByClientIdModel getCostByClientIdModelFromJson(String str) =>
    GetCostByClientIdModel.fromJson(json.decode(str));

String getCostByClientIdModelToJson(GetCostByClientIdModel data) =>
    json.encode(data.toJson());

class GetCostByClientIdModel {
  GetCostByClientIdModel({
    this.id,
    this.subCategoryId,
    this.subCategoryName,
    this.colorId,
    this.colorName,
    this.width,
    this.height,
    this.mortal,
    this.expenses,
    this.totalCalc,
    this.clientId,
    this.costCalcItems,
  });

  int id;
  int subCategoryId;
  String subCategoryName;
  int colorId;
  String colorName;
  String width;
  String height;
  dynamic mortal;
  dynamic expenses;
  dynamic totalCalc;
  dynamic clientId;
  List<CostCalcItem> costCalcItems;

  factory GetCostByClientIdModel.fromJson(Map<String, dynamic> json) =>
      GetCostByClientIdModel(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        colorId: json["colorId"],
        colorName: json["colorName"],
        width: json["width"],
        height: json["height"],
        mortal: json["mortal"],
        expenses: json["expenses"],
        totalCalc: json["totalCalc"],
        clientId: json["clientId"],
        costCalcItems: List<CostCalcItem>.from(
            json["costCalcItems"].map((x) => CostCalcItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "colorId": colorId,
        "colorName": colorName,
        "width": width,
        "height": height,
        "mortal": mortal,
        "expenses": expenses,
        "totalCalc": totalCalc,
        "clientId": clientId,
        "costCalcItems":
            List<dynamic>.from(costCalcItems.map((x) => x.toJson())),
      };
}

class CostCalcItem {
  CostCalcItem({
    this.costCalculationId,
    this.productId,
    this.meter,
    this.cost,
    this.totalMeterCost,
    this.descount,
    this.typeOfDescount,
    this.totalByDescount,
  });

  int costCalculationId;
  int productId;
  String meter;
  String cost;
  String totalMeterCost;
  dynamic descount;
  String typeOfDescount;
  String totalByDescount;

  factory CostCalcItem.fromJson(Map<String, dynamic> json) => CostCalcItem(
        costCalculationId: json["costCalculationId"],
        productId: json["productId"],
        meter: json["meter"],
        cost: json["cost"],
        totalMeterCost: json["totalMeterCost"],
        descount: json["descount"],
        typeOfDescount: json["typeOfDescount"],
        totalByDescount: json["totalByDescount"],
      );

  Map<String, dynamic> toJson() => {
        "costCalculationId": costCalculationId,
        "productId": productId,
        "meter": meter,
        "cost": cost,
        "totalMeterCost": totalMeterCost,
        "descount": descount,
        "typeOfDescount": typeOfDescount,
        "totalByDescount": totalByDescount,
      };
}
