import 'package:wordpress_companion/features/tags/data/models/tag_model.dart';

abstract class TagsRemoteDataSource {
  Future<TagModel> createTag(String name);
  Future<List<TagModel>> getTagsByIds(List<int> ids);
  Future<List<TagModel>> searchTag(String value);
}
