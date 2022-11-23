import 'dart:convert';

DiscountEntity discountEntityFromJson(String str) =>
    DiscountEntity.fromJson(json.decode(str));

String discountEntityToJson(DiscountEntity data) => json.encode(data.toJson());

class DiscountEntity {
  DiscountEntity({
    this.id,
    this.type = 1,
    required this.title,
    required this.discountAmount,
    required this.amountType,
    required this.expiredDate,
    required this.minAmount,
    required this.maxAmount,
    required this.totalNum,
  });

  int? id;

  /// 类型 0-折扣 1-优惠卷
  int type;
  String title;

  /// 折扣金额
  double discountAmount;

  /// 折扣类型 0-面值 1-百分比
  int amountType;

  /// 有效期限
  int expiredDate;

  /// 最小金额
  double minAmount;

  /// 最大金额
  double maxAmount;

  /// 发现数量
  int totalNum;

  factory DiscountEntity.fromJson(Map<String, dynamic> json) => DiscountEntity(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        discountAmount: json["discount_amount"],
        amountType: json["amount_type"],
        expiredDate: json["expired_date"],
        minAmount: json["min_amount"],
        maxAmount: json["max_amount"],
        totalNum: json["total_num"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "discount_amount": discountAmount,
        "amount_type": amountType,
        "expired_date": expiredDate,
        "min_amount": minAmount,
        "max_amount": maxAmount,
        "total_num": totalNum,
      };
}
