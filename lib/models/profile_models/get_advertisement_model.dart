// To parse this JSON data, do
//
//     final postAdverModel = postAdverModelFromJson(jsonString);

import 'dart:convert';

/// @suraj96506 add document comments for this

class PostAdverModel {
  PostAdverModel({
    required this.message,
    required this.insertLink,
  });

  final String message;
  final InsertLink insertLink;

  factory PostAdverModel.fromRawJson(String str) =>
      PostAdverModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostAdverModel.fromJson(Map<String, dynamic> json) => PostAdverModel(
        message: json["message"],
        insertLink: InsertLink.fromJson(json["insertLink"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "insertLink": insertLink.toJson(),
      };
}

class InsertLink {
  InsertLink({
    required this.link,
    required this.id,
    required this.date,
    required this.v,
  });

  final String link;
  final String id;
  final DateTime date;
  final int v;

  factory InsertLink.fromRawJson(String str) =>
      InsertLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsertLink.fromJson(Map<String, dynamic> json) => InsertLink(
        link: json["link"],
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "_id": id,
        "date": date.toIso8601String(),
        "__v": v,
      };
}
