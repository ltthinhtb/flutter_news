class CategoryResponse {
  List<ListCategory> listCategory;

  CategoryResponse({this.listCategory});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['list_category'] != null) {
      listCategory = new List<ListCategory>();
      json['list_category'].forEach((v) {
        listCategory.add(new ListCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCategory != null) {
      data['list_category'] = this.listCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListCategory {
  Category category;

  ListCategory({this.category});

  ListCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  String name;
  String categoryId;
  String url;

  Category({this.name, this.categoryId, this.url});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['category_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['url'] = this.url;
    return data;
  }
}
