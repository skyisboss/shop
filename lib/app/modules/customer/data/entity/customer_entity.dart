import 'dart:convert';

CustomerEntity customerEntityFromJson(String str) =>
    CustomerEntity.fromJson(json.decode(str));

String customerEntityToJson(CustomerEntity data) => json.encode(data.toJson());

class CustomerEntity {
  CustomerEntity({
    this.id,
    this.username,
    this.avatar,
    this.telephone,
    this.groupId = 1,
    // this.spendCount = 0,
    // this.timesCount = 0,
    this.pointCount = 0,
    this.gender = 0,
    this.address,
    this.birthday,
    this.remark,
    this.recentSpend,
    this.createAt,
  });

  int? id;
  String? username;
  String? avatar;
  String? telephone;
  int? groupId;
  int? gender;
  // double? spendCount;
  // int? timesCount;
  int? pointCount;
  String? address;
  String? birthday;
  String? remark;
  String? recentSpend;
  int? createAt;

  factory CustomerEntity.fromJson(Map<String, dynamic> json) => CustomerEntity(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        telephone: json["telephone"],
        groupId: json["group_id"],
        gender: json["gender"],
        // spendCount: json["spend_count"],
        // timesCount: json["times_count"],
        pointCount: json["point_count"],
        address: json["address"],
        birthday: json["birthday"],
        remark: json["remark"],
        recentSpend: json["recent_spend"],
        createAt: json["create_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "telephone": telephone,
        "group_id": groupId,
        "gender": gender,
        // "spend_count": spendCount,
        // "times_count": timesCount,
        "point_count": pointCount,
        "address": address,
        "birthday": birthday,
        "remark": remark,
        "recent_spend": recentSpend,
        "create_at": createAt,
      };
}
