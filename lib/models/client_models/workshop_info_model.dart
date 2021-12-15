// To parse this JSON data, do
//
//     final getWorkShopByClientModel = getWorkShopByClientModelFromJson(jsonString);

import 'dart:convert';

GetWorkShopInfoModel getWorkShopInfoModelFromJson(String str) =>
    GetWorkShopInfoModel.fromJson(json.decode(str));

String getWorkShopInfoModelToJson(GetWorkShopInfoModel data) =>
    json.encode(data.toJson());

class GetWorkShopInfoModel {
  GetWorkShopInfoModel({
    this.result,
    this.id,
    this.exception,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.isCompletedSuccessfully,
    this.creationOptions,
    this.asyncState,
    this.isFaulted,
  });

  Result result;
  int id;
  dynamic exception;
  int status;
  bool isCanceled;
  bool isCompleted;
  bool isCompletedSuccessfully;
  int creationOptions;
  dynamic asyncState;
  bool isFaulted;

  factory GetWorkShopInfoModel.fromJson(Map<String, dynamic> json) =>
      GetWorkShopInfoModel(
        result: Result.fromJson(json["result"]),
        id: json["id"],
        exception: json["exception"],
        status: json["status"],
        isCanceled: json["isCanceled"],
        isCompleted: json["isCompleted"],
        isCompletedSuccessfully: json["isCompletedSuccessfully"],
        creationOptions: json["creationOptions"],
        asyncState: json["asyncState"],
        isFaulted: json["isFaulted"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "id": id,
        "exception": exception,
        "status": status,
        "isCanceled": isCanceled,
        "isCompleted": isCompleted,
        "isCompletedSuccessfully": isCompletedSuccessfully,
        "creationOptions": creationOptions,
        "asyncState": asyncState,
        "isFaulted": isFaulted,
      };
}

class Result {
  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    this.parentName,
    this.name,
    this.nameAgent,
    this.agentLogo,
    this.agentGovernorate,
    this.agentAddress,
    this.agentPhone,
    this.userId,
    this.email,
    this.long,
    this.late,
  });

  int id;
  dynamic parentName;
  String name;
  String nameAgent;
  String agentLogo;
  String agentGovernorate;
  String agentAddress;
  String agentPhone;
  dynamic userId;
  String email;
  String long;
  String late;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        parentName: json["parentName"],
        name: json["name"],
        nameAgent: json["nameAgent"],
        agentLogo: json["agentLogo"],
        agentGovernorate: json["agentGovernorate"],
        agentAddress: json["agentAddress"],
        agentPhone: json["agentPhone"],
        userId: json["userId"],
        email: json["email"],
        long: json["long"],
        late: json["late"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentName": parentName,
        "name": name,
        "nameAgent": nameAgent,
        "agentLogo": agentLogo,
        "agentGovernorate": agentGovernorate,
        "agentAddress": agentAddress,
        "agentPhone": agentPhone,
        "userId": userId,
        "email": email,
        "long": long,
        "late": late,
      };
}
