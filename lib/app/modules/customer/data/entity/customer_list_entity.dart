import 'dart:convert';

CustomerListEntity customerListEntityFromJson(String str) =>
    CustomerListEntity.fromJson(json.decode(str));

String customerListEntityToJson(CustomerListEntity data) =>
    json.encode(data.toJson());

class CustomerListEntity {
  CustomerListEntity({
    this.id,
    this.username,
    this.avatar,
    this.groupName,
    this.groupId,
    this.spendCount = 0,
    this.timesCount = 0,
  });

  int? id;
  String? username;
  String? avatar;
  int? groupId;
  String? groupName;
  double? spendCount;
  int? timesCount;

  factory CustomerListEntity.fromJson(Map<String, dynamic> json) =>
      CustomerListEntity(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        groupName: json["group_name"],
        groupId: json["group_id"],
        spendCount: json["spend_count"] ?? 0,
        timesCount: json["times_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "group_name": groupName,
        "group_id": groupId,
        "spend_count": spendCount,
        "times_count": timesCount,
      };
}
