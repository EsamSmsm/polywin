// To parse this JSON data, do
//
//     final addAccountResponse = addAccountResponseFromJson(jsonString);

import 'dart:convert';

AddAccountResponse addAccountResponseFromJson(String str) => AddAccountResponse.fromJson(json.decode(str));

String addAccountResponseToJson(AddAccountResponse data) => json.encode(data.toJson());

class AddAccountResponse {
  AddAccountResponse({
    this.status,
    this.code,
    this.message,
    this.payload,
    this.isSuccess,
  });

  String status;
  String code;
  String message;
  String payload;
  bool isSuccess;

  factory AddAccountResponse.fromJson(Map<String, dynamic> json) => AddAccountResponse(
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
