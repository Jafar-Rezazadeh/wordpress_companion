import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      child: ListTile(
        leading: _name(context),
        contentPadding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
        trailing: _trailing(context, category),
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

  Widget _trailing(BuildContext context, CategoryEntity category) {
    return SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              "تعداد: ${category.count}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          IconButton(
            key: const Key("edit_category"),
            onPressed: () {
              context.goNamed(createOrEditCategoryRoute, extra: category);
            },
            style: IconButton.styleFrom(foregroundColor: ColorPallet.lightBlue),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
