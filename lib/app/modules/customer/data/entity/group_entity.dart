import 'dart:convert';

GroupEntity groupEntityFromJson(String str) =>
    GroupEntity.fromJson(json.decode(str));

String groupEntityToJson(GroupEntity data) => json.encode(data.toJson());

class GroupEntity {
  GroupEntity({
    this.id,
    required this.groupName,
    this.groupDiscount,
  });

  int? id;
  String groupName;
  double? groupDiscount;

  factory GroupEntity.fromJson(Map<String, dynamic> json) => GroupEntity(
        id: json["id"],
        groupName: json["group_name"],
        groupDiscount: json["group_discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "group_discount": groupDiscount,
      };
}
