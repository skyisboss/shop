import 'dart:convert';

SpendEntity spendEntityFromJson(String str) =>
    SpendEntity.fromJson(json.decode(str));

String spendEntityToJson(SpendEntity data) => json.encode(data.toJson());

class SpendEntity {
  SpendEntity({
    this.id,
    required this.uid,
    required this.amount,
    this.orderId,
    this.createAt,
  });

  int? id;
  String uid;
  int amount;
  String? orderId;
  int? createAt;

  factory SpendEntity.fromJson(Map<String, dynamic> json) => SpendEntity(
        id: json["id"],
        uid: json["uid"],
        amount: json["amount"],
        orderId: json["order_id"],
        createAt: json["create_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "amount": amount,
        "order_id": orderId,
        "create_at": createAt,
      };
}
