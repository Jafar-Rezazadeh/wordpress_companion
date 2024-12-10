import 'package:dartz/dartz.dart' show Either, right, left;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/presentation/logic_holders/utils/category_order_by_enum_translator.dart';

import '../../categories_exports.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  //
  Either<List<CategoryEntity>, List<TreeOutPutItem<CategoryEntity>>>
      categories = left([]);
  GetAllCategoriesParams params = GetAllCategoriesParams();
  final orderByTranslator = CategoryOrderByEnumTranslator();

  @override
  void initState() {
    super.initState();
    _getAllCategories();
  }

  void _getAllCategories() {
    context.read<CategoriesCubit>().getAllCategories(params);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            _pageHeader(),
            _categoriesBuilder(),
          ],
        ),
        floatingActionButton: _addNewCategory(context),
      ),
    );
  }

  Widget _addNewCategory(BuildContext context) {
    return FloatingActionButton(
      heroTag: "add_category_hero_tag",
      key: const Key("add_category"),
      onPressed: () => Get.toNamed(createOrEditCategoryRoute),
      child: const Icon(Icons.add),
    );
  }

  PageHeaderLayout _pageHeader() {
    return PageHeaderLayout(
      leftWidget: _searchInput(),
      rightWidget: _filterButton(),
    );
  }

  Widget _searchInput() {
    return CustomSearchInput(
      onSubmit: (value) {
        params.setSearch(value);
        _getAllCategories();
      },
      onClear: () {
        params.setSearch(null);
        _getAllCategories();
      },
    );
  }

  Widget _filterButton() {
    return FilterButton(
      numberOfAppliedFilters: params.orderby == null ? null : 1,
      onPressed: () {
        CustomBottomSheets.showFilterBottomSheet(
          context: context,
          onApply: () => setState(() => _getAllCategories()),
          onClear: () {
            setState(() => params.setOrderBy(null));
            _getAllCategories();
          },
          children: [
            _orderByFilter(),
          ],
        );
      },
    );
  }

  Widget _orderByFilter() {
    return Row(
      key: const Key("orderby_filter"),
      children: [
        const Text("ترتیب: "),
        const Gap(20),
        Expanded(
          child: CustomDropDownButton<CategoryOrderByEnum?>(
            initialValue: params.orderby,
            items: [
              _defaultOrderByItem(),
              ..._dropDownItems(),
            ],
            onChanged: (value) => params.setOrderBy(value),
          ),
        )
      ],
    );
  }

  DropdownMenuItem<Null> _defaultOrderByItem() {
    return const DropdownMenuItem(
      value: null,
      alignment: Alignment.centerRight,
      child: Text("پیشفرض"),
    );
  }

  Iterable<DropdownMenuItem<CategoryOrderByEnum>> _dropDownItems() {
    return CategoryOrderByEnum.values.map(
      (e) => DropdownMenuItem(
        value: e,
        alignment: Alignment.centerRight,
        child: Text(orderByTranslator.translate(e)),
      ),
    );
  }

  Expanded _categoriesBuilder() {
    return Expanded(
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: _categoriesStateListener,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const LoadingWidget(),
            orElse: () => _categoriesListView(),
          );
        },
      ),
    );
  }

  void _categoriesStateListener(_, CategoriesState state) {
    state.whenOrNull(
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
      needRefresh: () {
        _resetParams();
        _getAllCategories();
      },
      loaded: (data) {
        if (_paramsIsNull) {
          _makeTreeStructure(data);
        } else {
          categories = left(data);
        }
      },
    );
  }

  bool get _paramsIsNull => params.orderby == null && params.search == null;

  void _makeTreeStructure(List<CategoryEntity> data) {
    final treeInputs = data
        .map((e) => TreeInputItem(id: e.id, parentId: e.parent, data: e))
        .toList();

    categories = right(TreeBuilder<CategoryEntity>().buildTree(treeInputs));
  }

  Widget _categoriesListView() {
    return RefreshIndicator(
      onRefresh: () async {
        _resetParams();
        _getAllCategories();
      },
      child: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: categories.fold(
          (categories) => categories
              .map((e) => CategoryItemWidget(category: e, depth: 0))
              .toList(),
          (tree) => tree.map((node) => _categoryNode(node)).toList(),
        ),
      ),
    );
  }

  void _resetParams() {
    params = GetAllCategoriesParams();
  }

  Column _categoryNode(TreeOutPutItem<CategoryEntity> node) {
    return Column(
      key: Key("category_node_${node.data.id}"),
      children: [
        CategoryItemWidget(category: node.data, depth: node.depth),
        ...node.children.map((child) => _categoryNode(child)),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
