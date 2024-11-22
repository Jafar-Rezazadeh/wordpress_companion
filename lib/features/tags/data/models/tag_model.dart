import 'package:wordpress_companion/features/tags/tags_exports.dart';

class TagModel extends TagEntity {
  const TagModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.description,
    required super.count,
  });

  factory TagModel.fromJson(dynamic json) {
    return TagModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      count: json["count"],
    );
  }

  static Map<String, dynamic> fromParamsToJson(String name) {
    return {
      "name": name,
    };
  }
}
