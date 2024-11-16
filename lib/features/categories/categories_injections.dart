import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

initCategoriesInjections(GetIt getIt) {
  // data sources
  final categoriesRemoteDataSource = CategoriesRemoteDataSourceImpl(
    dio: getIt(),
  );

  // repository
  final categoriesRepository = CategoriesRepositoryImpl(
    categoriesRemoteDataSource: categoriesRemoteDataSource,
  );

  // cubits
  getIt.registerFactory(
    () => CategoriesCubit(
      getAllCategories:
          GetAllCategories(categoriesRepository: categoriesRepository),
      createCategory:
          CreateCategory(categoriesRepository: categoriesRepository),
      updateCategory:
          UpdateCategory(categoriesRepository: categoriesRepository),
      deleteCategory:
          DeleteCategory(categoriesRepository: categoriesRepository),
    ),
  );
}
