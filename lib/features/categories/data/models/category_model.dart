import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.count,
    required super.description,
    required super.link,
    required super.name,
    required super.slug,
    required super.parent,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      count: json["count"],
      description: json["description"],
      link: json["link"],
      name: json["name"],
      slug: json["slug"],
      parent: json["parent"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "slug": slug,
      "parent": parent,
      "description": description,
    };
  }

  static Map<String, dynamic> fromParamsToJson(
    CreateOrUpdateCategoryParams params,
  ) {
    return CategoryModel(
      id: 0,
      count: 0,
      description: params.description ?? "",
      link: "",
      name: params.name,
      slug: params.slug ?? "",
      parent: params.parent ?? 0,
    ).toJson();
  }
}
