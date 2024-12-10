import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final int depth;

  const CategoryItemWidget({
    super.key,
    required this.category,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () =>
            Get.toNamed(createOrEditCategoryRoute, arguments: category),
        leading: _name(context),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: edgeToEdgePaddingHorizontal,
          vertical: 5,
        ),
        trailing: _count(context),
      ),
    );
  }

  Text _name(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        if (depth > 0)
          TextSpan(
            text: "${"—" * depth} ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        TextSpan(text: category.name.ellipsSize(maxLength: 50))
      ]),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _count(BuildContext context) {
    return Text(
      "تعداد: ${category.count}",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}
