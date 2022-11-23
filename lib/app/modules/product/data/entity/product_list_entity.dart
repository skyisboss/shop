import 'product_entity.dart';

class ProductListEntity {
  ProductListEntity({
    required this.categoryId,
    required this.productList,
  });

  int categoryId;
  List<ProductEntity> productList;

  factory ProductListEntity.fromJson(Map<String, dynamic> json) =>
      ProductListEntity(
        categoryId: json["categoryId"],
        productList:
            List<ProductEntity>.from(json["productList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "productList": List<ProductEntity>.from(productList.map((x) => x)),
      };
}
