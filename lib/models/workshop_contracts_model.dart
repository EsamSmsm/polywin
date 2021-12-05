// To parse this JSON data, do
//
//     final workshopContractsModel = workshopContractsModelFromJson(jsonString);

import 'dart:convert';

WorkshopContractsModel workshopContractsModelFromJson(String str) =>
    WorkshopContractsModel.fromJson(json.decode(str));

String workshopContractsModelToJson(WorkshopContractsModel data) =>
    json.encode(data.toJson());

class WorkshopContractsModel {
  WorkshopContractsModel({
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

  factory WorkshopContractsModel.fromJson(Map<String, dynamic> json) =>
      WorkshopContractsModel(
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
    this.invoicesNumber,
    this.clientName,
    this.clientTypeName,
    this.phone,
    this.address,
    this.totalContract,
    this.workShopName,
    this.workShopAddress,
    this.workShopPhone,
    this.listItem,
  });

  int id;
  int invoicesNumber;
  String clientName;
  dynamic clientTypeName;
  String phone;
  String address;
  double totalContract;
  dynamic workShopName;
  dynamic workShopAddress;
  dynamic workShopPhone;
  List<ListItem> listItem;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        invoicesNumber: json["invoicesNumber"],
        clientName: json["clientName"],
        clientTypeName: json["clientTypeName"],
        phone: json["phone"],
        address: json["address"],
        totalContract: json["totalContract"].toDouble(),
        workShopName: json["workShopName"],
        workShopAddress: json["workShopAddress"],
        workShopPhone: json["workShopPhone"],
        listItem: List<ListItem>.from(
            json["listItem"].map((x) => ListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoicesNumber": invoicesNumber,
        "clientName": clientName,
        "clientTypeName": clientTypeName,
        "phone": phone,
        "address": address,
        "totalContract": totalContract,
        "workShopName": workShopName,
        "workShopAddress": workShopAddress,
        "workShopPhone": workShopPhone,
        "listItem": List<dynamic>.from(listItem.map((x) => x.toJson())),
      };
}

class ListItem {
  ListItem({
    this.id,
    this.productId,
    this.productName,
  });

  int id;
  int productId;
  String productName;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        id: json["id"],
        productId: json["productId"],
        productName: json["productName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productName": productName,
      };
}
