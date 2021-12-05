// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
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

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.userName,
    this.email,
    this.phoneNumber,
    this.token,
    this.password,
    this.endDate,
    this.roles,
    this.userId,
    this.userType,
    this.userTypeName,
    this.managerId,
    this.listDescount,
  });

  String id;
  String userName;
  dynamic email;
  dynamic phoneNumber;
  String token;
  dynamic password;
  DateTime endDate;
  dynamic roles;
  String userId;
  int userType;
  dynamic userTypeName;
  dynamic managerId;
  List<ListDescount> listDescount;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    token: json["token"],
    password: json["password"],
    endDate: DateTime.parse(json["endDate"]),
    roles: json["roles"],
    userId: json["userId"],
    userType: json["userType"],
    userTypeName: json["userTypeName"],
    managerId: json["managerId"],
    listDescount: List<ListDescount>.from(json["listDescount"].map((x) => ListDescount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email": email,
    "phoneNumber": phoneNumber,
    "token": token,
    "password": password,
    "endDate": endDate.toIso8601String(),
    "roles": roles,
    "userId": userId,
    "userType": userType,
    "userTypeName": userTypeName,
    "managerId": managerId,
    "listDescount": List<dynamic>.from(listDescount.map((x) => x.toJson())),
  };
}

class ListDescount {
  ListDescount({
    this.id,
    this.typeOfDescount,
    this.typeOfDescountName,
    this.descount,
    this.typeofProduct,
    this.typeofProductName,
  });

  int id;
  int typeOfDescount;
  String typeOfDescountName;
  double descount;
  int typeofProduct;
  String typeofProductName;

  factory ListDescount.fromJson(Map<String, dynamic> json) => ListDescount(
    id: json["id"],
    typeOfDescount: json["typeOfDescount"],
    typeOfDescountName: json["typeOfDescountName"],
    descount: json["descount"],
    typeofProduct: json["typeofProduct"],
    typeofProductName: json["typeofProductName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeOfDescount": typeOfDescount,
    "typeOfDescountName": typeOfDescountName,
    "descount": descount,
    "typeofProduct": typeofProduct,
    "typeofProductName": typeofProductName,
  };
}
