// To parse this JSON data, do
//
//     final getCompanyInfoModel = getCompanyInfoModelFromJson(jsonString);

import 'dart:convert';

GetCompanyInfoModel getCompanyInfoModelFromJson(String str) => GetCompanyInfoModel.fromJson(json.decode(str));

String getCompanyInfoModelToJson(GetCompanyInfoModel data) => json.encode(data.toJson());

class GetCompanyInfoModel {
  GetCompanyInfoModel({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  Payload payload;
  bool isSuccess;

  factory GetCompanyInfoModel.fromJson(Map<String, dynamic> json) => GetCompanyInfoModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    payload: Payload.fromJson(json["payload"]),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "payload": payload.toJson(),
    "isSuccess": isSuccess,
  };
}

class Payload {
  Payload({
    this.id,
    this.futureInfo,
    this.companyFile,
    this.companyInfo,
    this.file,
  });

  int id;
  String futureInfo;
  String companyFile;
  String companyInfo;
  dynamic file;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    futureInfo: json["futureInfo"],
    companyFile: json["companyFile"],
    companyInfo: json["companyInfo"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "futureInfo": futureInfo,
    "companyFile": companyFile,
    "companyInfo": companyInfo,
    "file": file,
  };
}
