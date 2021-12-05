// To parse this JSON data, do
//
//     final getAgentsStatisticsModel = getAgentsStatisticsModelFromJson(jsonString);

import 'dart:convert';

GetAgentsStatisticsModel getAgentsStatisticsModelFromJson(String str) => GetAgentsStatisticsModel.fromJson(json.decode(str));

String getAgentsStatisticsModelToJson(GetAgentsStatisticsModel data) => json.encode(data.toJson());

class GetAgentsStatisticsModel {
  GetAgentsStatisticsModel({
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

  factory GetAgentsStatisticsModel.fromJson(Map<String, dynamic> json) => GetAgentsStatisticsModel(
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
    this.agentName,
    this.totalInvoices,
    this.totalPayed,
    this.agentLogo,
  });

  String agentName;
  double totalInvoices;
  double totalPayed;
  String agentLogo;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    agentName: json["agentName"],
    totalInvoices: json["totalInvoices"].toDouble(),
    totalPayed: json["totalPayed"].toDouble(),
    agentLogo: json["agentLogo"],
  );

  Map<String, dynamic> toJson() => {
    "agentName": agentName,
    "totalInvoices": totalInvoices,
    "totalPayed": totalPayed,
    "agentLogo": agentLogo,
  };
}
