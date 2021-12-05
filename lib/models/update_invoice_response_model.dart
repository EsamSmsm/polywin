// To parse this JSON data, do
//
//     final updateInvoiceResponseModel = updateInvoiceResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateInvoiceResponseModel updateInvoiceResponseModelFromJson(String str) => UpdateInvoiceResponseModel.fromJson(json.decode(str));

String updateInvoiceResponseModelToJson(UpdateInvoiceResponseModel data) => json.encode(data.toJson());

class UpdateInvoiceResponseModel {
  UpdateInvoiceResponseModel({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  bool payload;
  bool isSuccess;

  factory UpdateInvoiceResponseModel.fromJson(Map<String, dynamic> json) => UpdateInvoiceResponseModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    payload: json["payload"],
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "payload": payload,
    "isSuccess": isSuccess,
  };
}
