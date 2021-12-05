// To parse this JSON data, do
//
//     final getWorkshopsModel = getWorkshopsModelFromJson(jsonString);

import 'dart:convert';

GetWorkshopsModel getWorkshopsModelFromJson(String str) => GetWorkshopsModel.fromJson(json.decode(str));

String getWorkshopsModelToJson(GetWorkshopsModel data) => json.encode(data.toJson());

class GetWorkshopsModel {
  GetWorkshopsModel({
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

  factory GetWorkshopsModel.fromJson(Map<String, dynamic> json) => GetWorkshopsModel(
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
    payload: List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
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
    this.name,
    this.nameAgent,
    this.agentLogo,
    this.agentGovernorate,
    this.agentAddress,
    this.agentPhone,
  });

  int id;
  String name;
  String nameAgent;
  String agentLogo;
  String agentGovernorate;
  String agentAddress;
  String agentPhone;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    name: json["name"],
    nameAgent: json["nameAgent"],
    agentLogo: json["agentLogo"],
    agentGovernorate: json["agentGovernorate"],
    agentAddress: json["agentAddress"],
    agentPhone: json["agentPhone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nameAgent": nameAgent,
    "agentLogo": agentLogo,
    "agentGovernorate": agentGovernorate,
    "agentAddress": agentAddress,
    "agentPhone": agentPhone,
  };
}
