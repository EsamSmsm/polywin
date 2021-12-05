// To parse this JSON data, do
//
//     final addNewContractResponseModel = addNewContractResponseModelFromJson(jsonString);

import 'dart:convert';

AddNewContractResponseModel addNewContractResponseModelFromJson(String str) => AddNewContractResponseModel.fromJson(json.decode(str));

String addNewContractResponseModelToJson(AddNewContractResponseModel data) => json.encode(data.toJson());

class AddNewContractResponseModel {
  AddNewContractResponseModel({
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

  factory AddNewContractResponseModel.fromJson(Map<String, dynamic> json) => AddNewContractResponseModel(
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
