// To parse this JSON data, do
//
//     final contractInfoModel = contractInfoModelFromJson(jsonString);

import 'dart:convert';

ContractInfoModel contractInfoModelFromJson(String str) =>
    ContractInfoModel.fromJson(json.decode(str));

String contractInfoModelToJson(ContractInfoModel data) =>
    json.encode(data.toJson());

class ContractInfoModel {
  ContractInfoModel({
    this.invoiceDate,
    this.workShopName,
    this.workShopUserName,
    this.workShopAddress,
    this.workShopLogo,
    this.clientName,
    this.clientAddress,
    this.clientPhone,
    this.total,
    this.itemList,
  });

  String invoiceDate;
  String workShopName;
  String workShopUserName;
  String workShopAddress;
  String workShopLogo;
  String clientName;
  String clientAddress;
  String clientPhone;
  String total;
  List<ItemList> itemList;

  factory ContractInfoModel.fromJson(Map<String, dynamic> json) =>
      ContractInfoModel(
        invoiceDate: json["invoiceDate"],
        workShopName: json["workShopName"],
        workShopUserName: json["workShopUserName"],
        workShopAddress: json["workShopAddress"],
        workShopLogo: json["workShopLogo"],
        clientName: json["clientName"],
        clientAddress: json["clientAddress"],
        clientPhone: json["clientPhone"],
        total: json["total"],
        itemList: List<ItemList>.from(
            json["itemList"].map((x) => ItemList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoiceDate": invoiceDate,
        "workShopName": workShopName,
        "workShopUserName": workShopUserName,
        "workShopAddress": workShopAddress,
        "workShopLogo": workShopLogo,
        "clientName": clientName,
        "clientAddress": clientAddress,
        "clientPhone": clientPhone,
        "total": total,
        "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
      };
}

class ItemList {
  ItemList({
    this.productName,
    this.width,
    this.heigth,
    this.color,
  });

  String productName;
  String width;
  String heigth;
  String color;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        productName: json["productName"],
        width: json["width"],
        heigth: json["heigth"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "width": width,
        "heigth": heigth,
        "color": color,
      };
}
