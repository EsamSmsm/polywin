// To parse this JSON data, do
//
//     final getCostByClientIdModel = getCostByClientIdModelFromJson(jsonString);

import 'dart:convert';

List<GetCostByClientIdModel> getCostByClientIdModelFromJson(String str) =>
    List<GetCostByClientIdModel>.from(
        json.decode(str).map((x) => GetCostByClientIdModel.fromJson(x)));

String getCostByClientIdModelToJson(List<GetCostByClientIdModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCostByClientIdModel {
  GetCostByClientIdModel({
    this.id,
    this.subCategoryId,
    this.subCategoryName,
    this.pathFile,
    this.colorId,
    this.colorName,
    this.width,
    this.height,
    this.mortal,
    this.expenses,
    this.totalCalc,
    this.net,
    this.clientId,
    this.costCalcItems,
  });

  int id;
  int subCategoryId;
  String subCategoryName;
  String pathFile;
  int colorId;
  String colorName;
  String width;
  String height;
  double mortal;
  int expenses;
  double totalCalc;
  double net;
  int clientId;
  List<CostCalcItem> costCalcItems;

  factory GetCostByClientIdModel.fromJson(Map<String, dynamic> json) =>
      GetCostByClientIdModel(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        pathFile: json["pathFile"],
        colorId: json["colorId"],
        colorName: json["colorName"],
        width: json["width"],
        height: json["height"],
        mortal: json["mortal"].toDouble(),
        expenses: json["expenses"],
        totalCalc: json["totalCalc"].toDouble(),
        net: json["net"].toDouble(),
        clientId: json["clientId"],
        costCalcItems: List<CostCalcItem>.from(
            json["costCalcItems"].map((x) => CostCalcItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "pathFile": pathFile,
        "colorId": colorId,
        "colorName": colorName,
        "width": width,
        "height": height,
        "mortal": mortal,
        "expenses": expenses,
        "totalCalc": totalCalc,
        "net": net,
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
  String descount;
  String typeOfDescount;
  String totalByDescount;

  factory CostCalcItem.fromJson(Map<String, dynamic> json) => CostCalcItem(
        costCalculationId: json["costCalculationId"],
        productId: json["productId"],
        meter: json["meter"],
        cost: json["cost"],
        totalMeterCost: json["totalMeterCost"],
        descount: json["descount"] == null ? null : json["descount"],
        typeOfDescount: json["typeOfDescount"],
        totalByDescount: json["totalByDescount"],
      );

  Map<String, dynamic> toJson() => {
        "costCalculationId": costCalculationId,
        "productId": productId,
        "meter": meter,
        "cost": cost,
        "totalMeterCost": totalMeterCost,
        "descount": descount == null ? null : descount,
        "typeOfDescount": typeOfDescount,
        "totalByDescount": totalByDescount,
      };
}
