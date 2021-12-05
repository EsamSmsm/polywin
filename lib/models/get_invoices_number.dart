// To parse this JSON data, do
//
//     final getInvoicesNumber = getInvoicesNumberFromJson(jsonString);

import 'dart:convert';

GetInvoicesNumber getInvoicesNumberFromJson(String str) => GetInvoicesNumber.fromJson(json.decode(str));

String getInvoicesNumberToJson(GetInvoicesNumber data) => json.encode(data.toJson());

class GetInvoicesNumber {
  GetInvoicesNumber({
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

  factory GetInvoicesNumber.fromJson(Map<String, dynamic> json) => GetInvoicesNumber(
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
