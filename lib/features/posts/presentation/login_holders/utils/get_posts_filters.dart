import 'package:wordpress_companion/core/constants/enums.dart';

class GetPostsFilters {
  String? _search;
  String? _after;
  String? _before;
  List<PostStatus> _status = PostStatus.values;
  List<int>? _categories;

  setSearch(String? value) {
    _search = value;
    return this;
  }

  setAfter(String? value) {
    _after = value;
    return this;
  }

  setBefore(String? value) {
    _before = value;
    return this;
  }

  setCategories(List<int>? value) {
    _categories = value;
    return this;
  }

  setStatus(List<PostStatus> status) {
    _status = status;
    return this;
  }

  String? get search => _search;
  String? get after => _after;
  String? get before => _before;
  List<int>? get categories => _categories;
  List<PostStatus> get status => _status;

  void reset() {
    _search = null;
    _after = null;
    _before = null;
    _categories = null;
    _status = PostStatus.values;
  }
}
