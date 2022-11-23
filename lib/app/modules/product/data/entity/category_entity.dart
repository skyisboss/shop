import 'dart:convert';

/// 店铺
CategoryEntity inventoryModelFromJson(String str) =>
    CategoryEntity.fromJson(json.decode(str));

String inventoryModelToJson(CategoryEntity data) => json.encode(data.toJson());

class CategoryEntity {
  int? id;
  int? sort;
  String name;

  CategoryEntity({
    this.id,
    this.sort,
    required this.name,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        id: json["id"],
        sort: json["sort"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() {
    var map = {
      "id": id,
      "sort": sort ?? 0,
      "name": name,
    };
    if (id == null) {
      map.remove('id');
    }
    return map;
  }

  Map<String, dynamic> toMap(CategoryEntity info) => {
        "id": id,
        "sort": sort,
        "name": name,
      };
}
