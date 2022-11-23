import 'dart:convert';

WalletEntity walletEntityFromJson(String str) =>
    WalletEntity.fromJson(json.decode(str));

String walletEntityToJson(WalletEntity data) => json.encode(data.toJson());

class WalletEntity {
  WalletEntity({
    this.id,
    this.name,
    this.logo,
  });

  int? id;
  String? name;
  String? logo;

  factory WalletEntity.fromJson(Map<String, dynamic> json) => WalletEntity(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}

class WalletFundsEntity {
  WalletFundsEntity({
    this.id,
    this.name,
    this.logo,
    this.timesCount,
    this.amountCount,
  });

  int? id;
  String? name;
  String? logo;
  int? timesCount;
  double? amountCount;

  factory WalletFundsEntity.fromJson(Map<String, dynamic> json) =>
      WalletFundsEntity(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        timesCount: json["times_count"],
        amountCount: json["amount_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "times_count": timesCount,
        "amount_count": amountCount,
      };
}
