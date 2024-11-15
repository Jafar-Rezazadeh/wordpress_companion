class CreateOrUpdateCategoryParams {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String description;

  CreateOrUpdateCategoryParams({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
  });
}
