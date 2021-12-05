// To parse this JSON data, do
//
//     final installmentModel = installmentModelFromJson(jsonString);

import 'dart:convert';

List<InstallmentModel> installmentModelFromJson(String str) => List<InstallmentModel>.from(json.decode(str).map((x) => InstallmentModel.fromJson(x)));

String installmentModelToJson(List<InstallmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InstallmentModel {
  InstallmentModel({
    this.clientId,
    this.costPerMonth,
    this.dateOfMonth,
  });

  dynamic clientId;
  int costPerMonth;
  String dateOfMonth;

  factory InstallmentModel.fromJson(Map<String, dynamic> json) => InstallmentModel(
    clientId: json["clientId"],
    costPerMonth: json["costPerMonth"],
    dateOfMonth: json["dateOfMonth"],
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "costPerMonth": costPerMonth,
    "dateOfMonth": dateOfMonth,
  };
}
