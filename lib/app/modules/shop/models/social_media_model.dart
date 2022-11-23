import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

SocialMediaModel socialMediaModelFromJson(String str) =>
    SocialMediaModel.fromJson(json.decode(str));

String socialMediaModelToJson(SocialMediaModel data) =>
    json.encode(data.toJson());

class SocialMediaModel {
  SocialMediaModel({
    required this.title,
    required this.logo,
    required this.color,
    required this.link,
    required this.active,
  });

  final String title;
  final String logo;
  final Color color;
  final Rx<String> link;
  final Rx<bool> active;

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) =>
      SocialMediaModel(
        title: json["title"],
        logo: json["logo"],
        color: json["color"],
        link: json["link"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "logo": logo,
        "color": color,
        "link": link,
        "active": active,
      };
}
