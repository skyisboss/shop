import 'dart:convert';

ProductEntity productEntityFromJson(String str) =>
    ProductEntity.fromJson(json.decode(str));

String productEntityToJson(ProductEntity data) => json.encode(data.toJson());

class ProductEntity {
  ProductEntity({
    this.id,
    required this.title,
    this.categoryId = 1,
    this.image,
    this.color,
    this.barcode,
    this.description,
    this.costPrice = 0,
    this.salePrice = 0,
    this.totalStock = 0,
    this.isInfinity = 0,
    this.saleOnline = 0,
    this.attribute,
    this.criterion,
    this.createAt,
  });

  int? id;
  String title;
  String? image;
  String? color;
  String? barcode;
  String? description;
  double? costPrice;
  double? salePrice;
  int? totalStock;
  int? isInfinity;
  int categoryId;
  int? saleOnline;
  String? attribute;
  String? criterion;
  int? createAt;

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        color: json["color"],
        barcode: json["barcode"],
        description: json["description"],
        costPrice: json["cost_price"],
        salePrice: json["sale_price"],
        totalStock: json["total_stock"],
        isInfinity: json["is_infinity"],
        categoryId: json["category_id"],
        saleOnline: json["sale_online"],
        attribute: json["attribute"],
        criterion: json["criterion"],
        createAt: json["create_at"],
      );

  Map<String, dynamic> toJson() {
    var maps = {
      "id": id,
      "title": title,
      "image": image,
      "color": color,
      "barcode": barcode,
      "description": description,
      "cost_price": costPrice,
      "sale_price": salePrice,
      "total_stock": totalStock,
      "is_infinity": isInfinity,
      "category_id": categoryId,
      "sale_online": saleOnline,
      "attribute": attribute,
      "criterion": criterion,
      "create_at": createAt ?? DateTime.now().millisecondsSinceEpoch,
    };
    if (id == null) {
      maps.remove('id');
    }
    return maps;
  }
}
