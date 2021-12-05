// To parse this JSON data, do
//
//     final createClintAccountResponse = createClintAccountResponseFromJson(jsonString);

import 'dart:convert';

CreateClintAccountResponse createClintAccountResponseFromJson(String str) => CreateClintAccountResponse.fromJson(json.decode(str));

String createClintAccountResponseToJson(CreateClintAccountResponse data) => json.encode(data.toJson());

class CreateClintAccountResponse {
  CreateClintAccountResponse({
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

  factory CreateClintAccountResponse.fromJson(Map<String, dynamic> json) => CreateClintAccountResponse(
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
