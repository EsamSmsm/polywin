// To parse this JSON data, do
//
//     final clientWarrantiesModel = clientWarrantiesModelFromJson(jsonString);

import 'dart:convert';

ClientWarrantiesModel clientWarrantiesModelFromJson(String str) =>
    ClientWarrantiesModel.fromJson(json.decode(str));

String clientWarrantiesModelToJson(ClientWarrantiesModel data) =>
    json.encode(data.toJson());

class ClientWarrantiesModel {
  ClientWarrantiesModel({
    this.id,
    this.productName,
    this.contractItemId,
    this.startSectorsWarrantyDate,
    this.endSectorsWarrantyDate,
    this.startAccessoresWarrantyDate,
    this.endAccessoresWarrantyDate,
    this.listImage,
  });

  int id;
  String productName;
  int contractItemId;
  DateTime startSectorsWarrantyDate;
  DateTime endSectorsWarrantyDate;
  DateTime startAccessoresWarrantyDate;
  DateTime endAccessoresWarrantyDate;
  List<dynamic> listImage;

  factory ClientWarrantiesModel.fromJson(Map<String, dynamic> json) =>
      ClientWarrantiesModel(
        id: json["id"],
        productName: json["productName"],
        contractItemId: json["contractItemId"],
        startSectorsWarrantyDate:
            DateTime.parse(json["startSectorsWarrantyDate"]),
        endSectorsWarrantyDate: DateTime.parse(json["endSectorsWarrantyDate"]),
        startAccessoresWarrantyDate:
            DateTime.parse(json["startAccessoresWarrantyDate"]),
        endAccessoresWarrantyDate:
            DateTime.parse(json["endAccessoresWarrantyDate"]),
        listImage: List<dynamic>.from(json["listImage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "contractItemId": contractItemId,
        "startSectorsWarrantyDate":
            "${startSectorsWarrantyDate.year.toString().padLeft(4, '0')}-${startSectorsWarrantyDate.month.toString().padLeft(2, '0')}-${startSectorsWarrantyDate.day.toString().padLeft(2, '0')}",
        "endSectorsWarrantyDate":
            "${endSectorsWarrantyDate.year.toString().padLeft(4, '0')}-${endSectorsWarrantyDate.month.toString().padLeft(2, '0')}-${endSectorsWarrantyDate.day.toString().padLeft(2, '0')}",
        "startAccessoresWarrantyDate":
            "${startAccessoresWarrantyDate.year.toString().padLeft(4, '0')}-${startAccessoresWarrantyDate.month.toString().padLeft(2, '0')}-${startAccessoresWarrantyDate.day.toString().padLeft(2, '0')}",
        "endAccessoresWarrantyDate":
            "${endAccessoresWarrantyDate.year.toString().padLeft(4, '0')}-${endAccessoresWarrantyDate.month.toString().padLeft(2, '0')}-${endAccessoresWarrantyDate.day.toString().padLeft(2, '0')}",
        "listImage": List<dynamic>.from(listImage.map((x) => x)),
      };
}
