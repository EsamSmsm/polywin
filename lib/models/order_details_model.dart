// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
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
  });

  int id;
  int productId;
  String productName;
  int numberIron;
  int typeOfProduct;
  String typeOfProductText;
  int quantity;
  int descount;
  int pricePerOne;
  int priceWithDescount;
  int pricePerMeter;
  bool isRecived;
  String imgUrl;
  int totalOrder;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
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
  };
}
