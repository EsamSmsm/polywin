// To parse this JSON data, do
//
//     final dataSheetModel = dataSheetModelFromJson(jsonString);

import 'dart:convert';

DataSheetModel dataSheetModelFromJson(String str) =>
    DataSheetModel.fromJson(json.decode(str));

String dataSheetModelToJson(DataSheetModel data) => json.encode(data.toJson());

class DataSheetModel {
  DataSheetModel({
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

  factory DataSheetModel.fromJson(Map<String, dynamic> json) => DataSheetModel(
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
    this.imagePath,
    this.fileUpload,
  });

  int id;
  String description;
  String imagePath;
  dynamic fileUpload;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        description: json["description"],
        imagePath: json["imagePath"],
        fileUpload: json["fileUpload"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "imagePath": imagePath,
        "fileUpload": fileUpload,
      };
}
