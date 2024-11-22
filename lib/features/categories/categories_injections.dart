import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/core/services/categories_service.dart';
import 'package:wordpress_companion/features/categories/application/categories_service_impl.dart';
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

  // useCases
  final getAllCategories =
      GetAllCategories(categoriesRepository: categoriesRepository);

  // application
  getIt.registerLazySingleton<CategoriesService>(
    () => CategoriesServiceImpl(getAllCategories: getAllCategories),
  );
  getIt.registerFactory(
    () => CategoriesCubit(
      getAllCategories: getAllCategories,
      createCategory:
          CreateCategory(categoriesRepository: categoriesRepository),
      updateCategory:
          UpdateCategory(categoriesRepository: categoriesRepository),
      deleteCategory:
          DeleteCategory(categoriesRepository: categoriesRepository),
    ),
  );
}
