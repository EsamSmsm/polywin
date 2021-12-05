// To parse this JSON data, do
//
//     final workshopFactorModel = workshopFactorModelFromJson(jsonString);

import 'dart:convert';

WorkshopFactorsFileModel workshopFactorModelFromJson(String str) =>
    WorkshopFactorsFileModel.fromJson(json.decode(str));

String workshopFactorModelToJson(WorkshopFactorsFileModel data) =>
    json.encode(data.toJson());

class WorkshopFactorsFileModel {
  WorkshopFactorsFileModel({
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

  factory WorkshopFactorsFileModel.fromJson(Map<String, dynamic> json) =>
      WorkshopFactorsFileModel(
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
    this.description,
    this.filePath,
    this.file,
    this.logoPath,
    this.logo,
  });

  int id;
  String description;
  String filePath;
  dynamic file;
  String logoPath;
  dynamic logo;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        description: json["description"],
        filePath: json["filePath"],
        file: json["file"],
        logoPath: json["logoPath"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "filePath": filePath,
        "file": file,
        "logoPath": logoPath,
        "logo": logo,
      };
}
