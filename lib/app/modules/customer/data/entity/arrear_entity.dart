import 'dart:convert';

ArrearEntity arrearEntityFromJson(String str) =>
    ArrearEntity.fromJson(json.decode(str));

String arrearEntityToJson(ArrearEntity data) => json.encode(data.toJson());

class ArrearEntity {
  ArrearEntity({
    this.id,
    required this.uid,
    this.amount,
    this.remark,
    this.isRepaid,
    this.repaidAt,
    this.createAt,
  });

  int? id;
  String uid;
  double? amount;
  String? remark;
  int? isRepaid;
  int? repaidAt;
  int? createAt;

  factory ArrearEntity.fromJson(Map<String, dynamic> json) => ArrearEntity(
        id: json["id"],
        uid: json["uid"],
        amount: json["amount"],
        remark: json["remark"],
        isRepaid: json["is_repaid"],
        repaidAt: json["repaid_at"],
        createAt: json["create_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "amount": amount,
        "remark": remark,
        "is_repaid": isRepaid,
        "repaid_at": repaidAt,
        "create_at": createAt,
      };
}
