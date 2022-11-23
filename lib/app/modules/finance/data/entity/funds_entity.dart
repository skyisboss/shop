import 'dart:convert';

FundsEntity fundsEntityFromJson(String str) =>
    FundsEntity.fromJson(json.decode(str));

String fundsEntityToJson(FundsEntity data) => json.encode(data.toJson());

class FundsEntity {
  FundsEntity({
    this.id,
    this.amount,
    this.type,
    this.walletId,
    this.remark,
    this.file,
    this.createAt,
  });

  int? id;
  double? amount;
  int? type;
  int? walletId;
  String? remark;
  String? file;
  int? createAt;

  factory FundsEntity.fromJson(Map<String, dynamic> json) => FundsEntity(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        walletId: json["wallet_id"],
        remark: json["remark"],
        file: json["file"],
        createAt: json["create_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "wallet_id": walletId,
        "remark": remark,
        "file": file,
        "create_at": createAt,
      };
}
