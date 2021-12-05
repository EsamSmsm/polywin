

import 'dart:convert';

CustomerWarrantiesModel customerWarrantiesModelFromJson(String str) => CustomerWarrantiesModel.fromJson(json.decode(str));

String customerWarrantiesModelToJson(CustomerWarrantiesModel data) => json.encode(data.toJson());

class CustomerWarrantiesModel {
  CustomerWarrantiesModel({
    this.id,
    this.productName,
    this.startWarrantyDate,
    this.endWarrantyDate,
  });

  int id;
  String productName;
  DateTime startWarrantyDate;
  DateTime endWarrantyDate;

  factory CustomerWarrantiesModel.fromJson(Map<String, dynamic> json) => CustomerWarrantiesModel(
    id: json["id"],
    productName: json["productName"],
    startWarrantyDate: DateTime.parse(json["startWarrantyDate"]),
    endWarrantyDate: DateTime.parse(json["endWarrantyDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productName": productName,
    "startWarrantyDate": startWarrantyDate.toIso8601String(),
    "endWarrantyDate": endWarrantyDate.toIso8601String(),
  };
}
