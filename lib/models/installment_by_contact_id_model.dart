// To parse this JSON data, do
//
//     final installmentByContractIdModel = installmentByContractIdModelFromJson(jsonString);

import 'dart:convert';

InstallmentByContractIdModel installmentByContractIdModelFromJson(String str) => InstallmentByContractIdModel.fromJson(json.decode(str));

String installmentByContractIdModelToJson(InstallmentByContractIdModel data) => json.encode(data.toJson());

class InstallmentByContractIdModel {
  InstallmentByContractIdModel({
    this.id,
    this.clientName,
    this.costPerMonth,
    this.dateOfMonth,
    this.type,
  });

  int id;
  String clientName;
  int costPerMonth;
  dynamic dateOfMonth;
  String type;

  factory InstallmentByContractIdModel.fromJson(Map<String, dynamic> json) => InstallmentByContractIdModel(
    id: json["id"],
    clientName: json["clientName"],
    costPerMonth: json["costPerMonth"],
    dateOfMonth: json["dateOfMonth"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clientName": clientName,
    "costPerMonth": costPerMonth,
    "dateOfMonth": dateOfMonth,
    "type": type,
  };
}
