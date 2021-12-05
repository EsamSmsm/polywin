// To parse this JSON data, do
//
//     final addInvoiceResponse = addInvoiceResponseFromJson(jsonString);

import 'dart:convert';

AddInvoiceResponse addInvoiceResponseFromJson(String str) => AddInvoiceResponse.fromJson(json.decode(str));

String addInvoiceResponseToJson(AddInvoiceResponse data) => json.encode(data.toJson());

class AddInvoiceResponse {
  AddInvoiceResponse({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  int payload;
  bool isSuccess;

  factory AddInvoiceResponse.fromJson(Map<String, dynamic> json) => AddInvoiceResponse(
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
