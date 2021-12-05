// To parse this JSON data, do
//
//     final getAgentsModel = getAgentsModelFromJson(jsonString);

import 'dart:convert';

GetAgentsModel getAgentsModelFromJson(String str) => GetAgentsModel.fromJson(json.decode(str));

String getAgentsModelToJson(GetAgentsModel data) => json.encode(data.toJson());

class GetAgentsModel {
  GetAgentsModel({
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

  factory GetAgentsModel.fromJson(Map<String, dynamic> json) => GetAgentsModel(
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
    this.id,
    this.name,
    this.nameAgent,
    this.agentLogo,
    this.agentGovernorate,
    this.agentAddress,
    this.agentPhone,
  });

  int id;
  String name;
  String nameAgent;
  String agentLogo;
  String agentGovernorate;
  String agentAddress;
  String agentPhone;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    name: json["name"],
    nameAgent: json["nameAgent"],
    agentLogo: json["agentLogo"],
    agentGovernorate: json["agentGovernorate"],
    agentAddress: json["agentAddress"],
    agentPhone: json["agentPhone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nameAgent": nameAgent,
    "agentLogo": agentLogo,
    "agentGovernorate": agentGovernorate,
    "agentAddress": agentAddress,
    "agentPhone": agentPhone,
  };
}
