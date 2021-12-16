// To parse this JSON data, do
//
//     final checkInstallmentsModel = checkInstallmentsModelFromJson(jsonString);

import 'dart:convert';

List<CheckInstallmentsModel> checkInstallmentsModelFromJson(String str) =>
    List<CheckInstallmentsModel>.from(
        json.decode(str).map((x) => CheckInstallmentsModel.fromJson(x)));

String checkInstallmentsModelToJson(List<CheckInstallmentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckInstallmentsModel {
  CheckInstallmentsModel({
    this.clientId,
    this.costPerMonth,
    this.dateOfMonth,
  });

  dynamic clientId;
  int costPerMonth;
  String dateOfMonth;

  factory CheckInstallmentsModel.fromJson(Map<String, dynamic> json) =>
      CheckInstallmentsModel(
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
