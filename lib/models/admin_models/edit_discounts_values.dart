// To parse this JSON data, do
//
//     final editDiscountsResponse = editDiscountsResponseFromJson(jsonString);

import 'dart:convert';

EditDiscountsResponse editDiscountsResponseFromJson(String str) => EditDiscountsResponse.fromJson(json.decode(str));

String editDiscountsResponseToJson(EditDiscountsResponse data) => json.encode(data.toJson());

class EditDiscountsResponse {
  EditDiscountsResponse({
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

  factory EditDiscountsResponse.fromJson(Map<String, dynamic> json) => EditDiscountsResponse(
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
