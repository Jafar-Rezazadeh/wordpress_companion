import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CategorySelectorWidget extends StatefulWidget {
  final List<int> initialSelectedCategories;
  final Function(List<CategoryEntity> categories) onSelect;
  const CategorySelectorWidget({
    super.key,
    required this.onSelect,
    this.initialSelectedCategories = const [],
  });

  @override
  State<CategorySelectorWidget> createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  late List<CategoryEntity> selectedCategories;

  @override
  void initState() {
    super.initState();
    _getCategoriesIfStateIsNotLoaded();
  }

  void _getCategoriesIfStateIsNotLoaded() {
    if (!_isCategoriesLoadedState()) {
      context.read<CategoriesCubit>().getAllCategories(
            GetAllCategoriesParams(),
          );
    }
  }

  bool _isCategoriesLoadedState() =>
      context.read<CategoriesCubit>().state.whenOrNull(loaded: (_) => true) ==
      true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initSelectedCategories();
  }

  void _initSelectedCategories() {
    context.watch<CategoriesCubit>().state.whenOrNull(
      loaded: (categories) {
        selectedCategories = categories
            .where((element) =>
                widget.initialSelectedCategories.contains(element.id))
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => const LoadingWidget(),
          loaded: (categories) => _categoriesSelector(categories),
          needRefresh: () => const Text(
              key: Key("needRefresh_text"), "لطفا دوباره امتحان کنید"),
          error: (failure) =>
              Text(key: const Key("failure_text"), failure.message),
        );
      },
    );
  }

  _categoriesSelector(List<CategoryEntity> categories) {
    final listOfCategoryNodes = _makeCategoryNodes(categories);

    return Column(
      key: const Key("categories_checkBoxes"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listOfCategoryNodes.map((node) => _nodeItem(node)).toList(),
    );
  }

  List<TreeOutPutItem<CategoryEntity>> _makeCategoryNodes(
      List<CategoryEntity> categories) {
    final treeInputs = categories
        .map((e) => TreeInputItem(id: e.id, parentId: e.parent, data: e))
        .toList();

    return TreeBuilder<CategoryEntity>().buildTree(treeInputs);
  }

  Column _nodeItem(TreeOutPutItem<CategoryEntity> node) {
    return Column(
      key: Key("category_node_${node.data.id}"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _categoryCheckBox(node.data),
        ..._children(node.children),
      ],
    );
  }

  CheckboxListTile _categoryCheckBox(CategoryEntity category) {
    return CheckboxListTile(
      title: Text(category.name),
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity: VisualDensity.compact,
      dense: true,
      value: selectedCategories.contains(category),
      onChanged: (value) {
        value == true
            ? selectedCategories.add(category)
            : selectedCategories.remove(category);

        widget.onSelect(selectedCategories);
        setState(() {});
      },
    );
  }

  Iterable<Widget> _children(List<TreeOutPutItem<CategoryEntity>> children) {
    return children.map(
      (child) => Padding(
        key: Key("category_child_node_${child.data.id}"),
        padding: const EdgeInsets.only(right: 16),
        child: _nodeItem(child),
      ),
    );
  }
}
