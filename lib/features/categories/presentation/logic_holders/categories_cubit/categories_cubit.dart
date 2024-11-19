import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

import '../../../../../core/core_export.dart';

part 'categories_state.dart';
part 'categories_cubit.freezed.dart';

// TODO: put this cubit in application layer

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategories _getAllCategories;
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  CategoriesCubit({
    required GetAllCategories getAllCategories,
    required CreateCategory createCategory,
    required UpdateCategory updateCategory,
    required DeleteCategory deleteCategory,
  })  : _getAllCategories = getAllCategories,
        _createCategory = createCategory,
        _updateCategory = updateCategory,
        _deleteCategory = deleteCategory,
        super(const CategoriesState.initial());

  getAllCategories(GetAllCategoriesParams params) async {
    emit(const CategoriesState.loading());

    final result = await _getAllCategories(params);

    result.fold(
      (failure) => emit(CategoriesState.error(failure)),
      (categories) => emit(CategoriesState.loaded(categories)),
    );
  }

  createCategory(CreateOrUpdateCategoryParams params) async {
    emit(const CategoriesState.loading());

    final result = await _createCategory(params);

    result.fold(
      (failure) => emit(CategoriesState.error(failure)),
      (_) => emit(const CategoriesState.needRefresh()),
    );
  }

  updateCategory(CreateOrUpdateCategoryParams params) async {
    emit(const CategoriesState.loading());

    final result = await _updateCategory(params);

    result.fold(
      (failure) => emit(CategoriesState.error(failure)),
      (_) => emit(const CategoriesState.needRefresh()),
    );
  }

  deleteCategory(int id) async {
    emit(const CategoriesState.loading());

    final result = await _deleteCategory(id);

    result.fold(
      (failure) => emit(CategoriesState.error(failure)),
      (_) => emit(const CategoriesState.needRefresh()),
    );
  }
}
