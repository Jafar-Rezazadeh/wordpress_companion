import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CreateOrEditCategoryScreen extends StatefulWidget {
  final CategoryEntity? category;
  final CreateOrUpdateCategoryParamsBuilder? paramsBuilderTest;
  const CreateOrEditCategoryScreen({
    super.key,
    this.category,
    this.paramsBuilderTest,
  });

  @override
  State<CreateOrEditCategoryScreen> createState() =>
      _CreateOrEditCategoryScreenState();
}

class _CreateOrEditCategoryScreenState
    extends State<CreateOrEditCategoryScreen> {
  final formKey = GlobalKey<FormState>();

  late CreateOrUpdateCategoryParamsBuilder _paramsBuilder;
  List<CategoryEntity> categories = [];

  @override
  void initState() {
    super.initState();
    _initParamsBuilder();
    _getCategories();
  }

  void _initParamsBuilder() {
    _paramsBuilder =
        widget.paramsBuilderTest ?? CreateOrUpdateCategoryParamsBuilder();
    if (widget.category != null) {
      _paramsBuilder.setInitValues(widget.category!);
    }
  }

  _getCategories() {
    if (_isStateNotLoaded()) {
      context
          .read<CategoriesCubit>()
          .getAllCategories(GetAllCategoriesParams());
    }
  }

  bool _isStateNotLoaded() {
    return context
        .read<CategoriesCubit>()
        .state
        .maybeWhen(loaded: (_) => false, orElse: () => true);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: _appBar(),
        body: _inputs(),
      ),
    );
  }

  PushedScreenAppBar _appBar() {
    return PushedScreenAppBar(
      title: widget.category == null ? "ایجاد دسته بندی" : "ویرایش دسته بندی",
      context: context,
      showLoading: _isLoadingState(),
      bottomLeadingWidgets: [_saveButton()],
      bottomActionWidgets: [if (widget.category != null) _deleteButton()],
    );
  }

  bool? _isLoadingState() {
    return context
        .watch<CategoriesCubit>()
        .state
        .whenOrNull(loading: () => true);
  }

  SaveButton _saveButton() {
    return SaveButton(
      onPressed: () => _isFormValid() ? _createOrUpdateCategory() : null,
    );
  }

  void _createOrUpdateCategory() {
    if (widget.category == null) {
      context.read<CategoriesCubit>().createCategory(_paramsBuilder.build());
    } else {
      context.read<CategoriesCubit>().updateCategory(_paramsBuilder.build());
    }
  }

  bool _isFormValid() => formKey.currentState?.validate() == true;

  IconButton _deleteButton() {
    return IconButton(
      key: const Key("delete_button"),
      onPressed: () {
        CustomDialogs.showAreYouSureDialog(
          context: context,
          title: "حذف برای همیشه!",
          content:
              "آیا مطمئن هستید که میخواهید (${widget.category?.name}) حذف کنید؟",
          onConfirm: () {
            if (widget.category != null) {
              context
                  .read<CategoriesCubit>()
                  .deleteCategory(widget.category!.id);
              Navigator.of(context).pop();
            }
          },
        );
      },
      iconSize: 30,
      color: ColorPallet.crimson,
      icon: const Icon(Icons.delete_outline),
    );
  }

  Widget _inputs() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: edgeToEdgePaddingHorizontal,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _name(),
              _slug(),
              _parent(),
              _description(),
            ].withGapInBetween(40),
          ),
        ),
      ),
    );
  }

  Widget _name() {
    return CustomFormInputField(
      key: const Key("name_input"),
      initialValue: widget.category?.name,
      label: "نام",
      validator: InputValidator.isNotEmpty,
      onChanged: (value) => _paramsBuilder.setName(value),
    );
  }

  Widget _slug() {
    return CustomFormInputField(
      initialValue: Uri.decodeComponent(widget.category?.slug ?? ""),
      label: "نامک",
      onChanged: (value) => _paramsBuilder.setSlug(value),
    );
  }

  Widget _parent() {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: _categoriesStateListener,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("دسته مادر:"),
            state.maybeWhen(
              loaded: (categories) {
                this.categories = categories;
                return _parentCategoryDropDownButton();
              },
              loading: () => const LoadingWidget(),
              orElse: () => _parentCategoryDropDownButton(),
            )
          ],
        );
      },
    );
  }

  void _categoriesStateListener(_, CategoriesState state) {
    state.whenOrNull(
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
    );
  }

  Widget _parentCategoryDropDownButton() {
    return CustomDropDownButton<CategoryEntity>(
      key: const Key("parent_selector"),
      initialValue: _getInitialParent(),
      items: _categoriesList(),
      onChanged: (value) => _paramsBuilder.setParent(value?.id),
    );
  }

  CategoryEntity? _getInitialParent() {
    final parentCategory = categories.where(
      (element) => element.id == widget.category?.parent,
    );

    return parentCategory.isNotEmpty ? parentCategory.first : null;
  }

  List<DropdownMenuItem<CategoryEntity>>? _categoriesList() {
    return [
      const DropdownMenuItem(value: null, child: Text("هیچکدام")),
      ...categories.map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
    ];
  }

  Widget _description() {
    return CustomFormInputField(
      initialValue: widget.category?.description,
      label: "توضیحات",
      maxLines: 5,
      onChanged: (value) => _paramsBuilder.setDescription(value),
    );
  }
}
