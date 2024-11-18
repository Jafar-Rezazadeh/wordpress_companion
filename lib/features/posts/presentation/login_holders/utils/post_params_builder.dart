import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/domain/entities/post_entity.dart';
import 'package:wordpress_companion/features/posts/domain/use_cases/post_params.dart';

class PostParamsBuilder {
  int _id = 0;
  String _title = "";
  String _slug = "";
  PostStatusEnum _status = PostStatusEnum.publish;
  String _content = "";
  String _excerpt = "";
  List<int> _categories = [];
  List<int> _tags = [];
  int _featuredImage = 0;

  void setInitialValues(PostEntity postEntity) {
    _id = postEntity.id;
    _title = postEntity.title;
    _slug = postEntity.slug;
    _status = postEntity.status;
    _content = postEntity.content;
    _excerpt = postEntity.excerpt;
    _categories = postEntity.categories;
    _tags = postEntity.tags;
    _featuredImage = postEntity.featuredMedia;
  }

  setTitle(String value) {
    _title = value;
    return this;
  }

  setSlug(String value) {
    _slug = value;
    return this;
  }

  setStatus(PostStatusEnum value) {
    _status = value;
    return this;
  }

  setContent(String value) {
    _content = value;
    return this;
  }

  setExcerpt(String value) {
    _excerpt = value;
    return this;
  }

  setCategories(List<int> value) {
    _categories = value;
    return this;
  }

  setTags(List<int> value) {
    _tags = value;
    return this;
  }

  setFeaturedImage(int value) {
    _featuredImage = value;
    return this;
  }

  PostStatusEnum get status => _status;

  PostParams build() {
    return PostParams(
      id: _id,
      title: _title,
      slug: _slug,
      status: _status,
      content: _content,
      excerpt: _excerpt,
      categories: _categories,
      tags: _tags,
      featuredImage: _featuredImage,
    );
  }
}
