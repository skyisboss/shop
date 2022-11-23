import 'dart:convert';

/// 店铺
ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  String? id;
  String key;
  String value;

  ShopModel({
    this.id,
    required this.key,
    required this.value,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"].toString(),
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() {
    var map = {
      "id": id,
      "key": key,
      "value": value,
    };
    if (id == null) {
      map.remove('id');
    }
    return map;
  }

  Map<String, dynamic> toMap(ShopModel info) => {
        "id": id,
        "key": key,
        "value": value,
      };
}
