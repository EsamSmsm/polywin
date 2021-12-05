// To parse this JSON data, do
//
//     final galleryModel = galleryModelFromJson(jsonString);

import 'dart:convert';

GalleryModel galleryModelFromJson(String str) => GalleryModel.fromJson(json.decode(str));

String galleryModelToJson(GalleryModel data) => json.encode(data.toJson());

class GalleryModel {
  GalleryModel({
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

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
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
    this.listGallery,
  });

  int id;
  String name;
  List<ListGallery> listGallery;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    name: json["name"],
    listGallery: List<ListGallery>.from(json["listGallery"].map((x) => ListGallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "listGallery": List<dynamic>.from(listGallery.map((x) => x.toJson())),
  };
}

class ListGallery {
  ListGallery({
    this.id,
    this.categoryChildName,
    this.filePath,
    this.gallery,
  });

  int id;
  String categoryChildName;
  dynamic filePath;
  List<Gallery> gallery;

  factory ListGallery.fromJson(Map<String, dynamic> json) => ListGallery(
    id: json["id"],
    categoryChildName: json["categoryChildName"],
    filePath: json["filePath"],
    gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryChildName": categoryChildName,
    "filePath": filePath,
    "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
  };
}

class Gallery {
  Gallery({
    this.id,
    this.pathImage,
    this.description,
    this.galleryType,
  });

  int id;
  String pathImage;
  String description;
  int galleryType;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    id: json["id"],
    pathImage: json["pathImage"],
    description: json["description"],
    galleryType: json["galleryType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pathImage": pathImage,
    "description": description,
    "galleryType": galleryType,
  };
}
