import '../../../categories_exports.dart';

class CreateOrUpdateCategoryParamsBuilder {
  int _id = 0;
  String _name = "";
  String? _description;
  String? _slug;
  int? _parent;

  void setInitValues(CategoryEntity category) {
    _id = category.id;
    _name = category.name;
    _description = category.description;
    _slug = category.slug;
    _parent = category.parent;
  }

  setName(String value) {
    _name = value;
    return this;
  }

  setDescription(String? value) {
    _description = value;
    return this;
  }

  setSlug(String? value) {
    _slug = value;
    return this;
  }

  setParent(int? value) {
    _parent = value;
    return this;
  }

  CreateOrUpdateCategoryParams build() {
    return CreateOrUpdateCategoryParams(
      id: _id,
      name: _name,
      description: _description,
      parent: _parent,
      slug: _slug,
    );
  }
}
