class GetPostsFilters {
  String? _search;
  String? _after;
  String? _before;
  List<int>? _categories;

  setSearch(String value) {
    _search = value;
    return this;
  }

  setAfter(String value) {
    _after = value;
    return this;
  }

  setBefore(String value) {
    _before = value;
    return this;
  }

  setCategories(List<int> value) {
    _categories = value;
    return this;
  }

  String? get search => _search;
  String? get after => _after;
  String? get before => _before;
  List<int>? get categories => _categories;

  void reset() {
    _search = null;
    _after = null;
    _before = null;
    _categories = null;
  }
}
