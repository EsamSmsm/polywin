// To parse this JSON data, do
//
//     final getAllInvoicesModel = getAllInvoicesModelFromJson(jsonString);

import 'dart:convert';

GetAllInvoicesModel getAllInvoicesModelFromJson(String str) => GetAllInvoicesModel.fromJson(json.decode(str));

String getAllInvoicesModelToJson(GetAllInvoicesModel data) => json.encode(data.toJson());

class GetAllInvoicesModel {
  GetAllInvoicesModel({
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

  factory GetAllInvoicesModel.fromJson(Map<String, dynamic> json) => GetAllInvoicesModel(
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
    this.order,
    this.id,
    this.invoicesNumber,
    this.invoicesDate,
    this.isRecived,
    this.isRecivedText,
    this.describtion,
    this.totalInvoices,
    this.descountInvoices,
    this.totalWithInvoices,
    this.totalPayed,
    this.totalAmount,
    this.details,
    this.fromUserId,
    this.toUserId,
    this.agent,
  });

  int order;
  int id;
  int invoicesNumber;
  DateTime invoicesDate;
  dynamic isRecived;
  String isRecivedText;
  String describtion;
  double totalInvoices;
  double descountInvoices;
  double totalWithInvoices;
  dynamic totalPayed;
  dynamic totalAmount;
  List<Detail> details;
  dynamic fromUserId;
  String toUserId;
  dynamic agent;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    order: json["order"],
    id: json["id"],
    invoicesNumber: json["invoicesNumber"],
    invoicesDate: DateTime.parse(json["invoicesDate"]),
    isRecived: json["isRecived"],
    isRecivedText: json["isRecivedText"],
    describtion: json["describtion"],
    totalInvoices: json["totalInvoices"].toDouble(),
    descountInvoices: json["descountInvoices"].toDouble(),
    totalWithInvoices: json["totalWithInvoices"].toDouble(),
    totalPayed: json["totalPayed"],
    totalAmount: json["totalAmount"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    fromUserId: json["fromUserId"],
    toUserId: json["toUserId"],
    agent: json["agent"],
  );

  Map<String, dynamic> toJson() => {
    "order": order,
    "id": id,
    "invoicesNumber": invoicesNumber,
    "invoicesDate": invoicesDate.toIso8601String(),
    "isRecived": isRecived,
    "isRecivedText": isRecivedText,
    "describtion": describtion,
    "totalInvoices": totalInvoices,
    "descountInvoices": descountInvoices,
    "totalWithInvoices": totalWithInvoices,
    "totalPayed": totalPayed,
    "totalAmount": totalAmount,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "fromUserId": fromUserId,
    "toUserId": toUserId,
    "agent": agent,
  };
}

class Detail {
  Detail({
    this.id,
    this.productId,
    this.productName,
    this.numberIron,
    this.typeOfProduct,
    this.typeOfProductText,
    this.quantity,
    this.descount,
    this.pricePerOne,
    this.priceWithDescount,
    this.pricePerMeter,
    this.isRecived,
    this.imgUrl,
    this.totalOrder,
    this.description,
  });

  int id;
  int productId;
  String productName;
  int numberIron;
  dynamic typeOfProduct;
  dynamic typeOfProductText;
  int quantity;
  dynamic descount;
  dynamic pricePerOne;
  dynamic priceWithDescount;
  dynamic pricePerMeter;
  dynamic isRecived;
  dynamic imgUrl;
  int totalOrder;
  dynamic description;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    productId: json["productId"],
    productName: json["productName"],
    numberIron: json["numberIron"],
    typeOfProduct: json["typeOfProduct"],
    typeOfProductText: json["typeOfProductText"],
    quantity: json["quantity"],
    descount: json["descount"],
    pricePerOne: json["pricePerOne"],
    priceWithDescount: json["priceWithDescount"],
    pricePerMeter: json["pricePerMeter"],
    isRecived: json["isRecived"],
    imgUrl: json["imgURL"],
    totalOrder: json["totalOrder"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "productName": productName,
    "numberIron": numberIron,
    "typeOfProduct": typeOfProduct,
    "typeOfProductText": typeOfProductText,
    "quantity": quantity,
    "descount": descount,
    "pricePerOne": pricePerOne,
    "priceWithDescount": priceWithDescount,
    "pricePerMeter": pricePerMeter,
    "isRecived": isRecived,
    "imgURL": imgUrl,
    "totalOrder": totalOrder,
    "description": description,
  };
}
