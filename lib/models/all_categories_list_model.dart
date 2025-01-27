class CategoriesItemModel {
  int? id;
  int? parentId;
  int? sectionId;
  String? categoryName;
  String? categoryImage;
  String? categoryBannerImage;
  int? categoryDiscount;
  dynamic description;
  String? url;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  CategoriesItemModel(
      {this.id,
      this.parentId,
      this.sectionId,
      this.categoryName,
      this.categoryImage,
      this.categoryBannerImage,
      this.categoryDiscount,
      this.description,
      this.url,
      this.metaTitle,
      this.metaDescription,
      this.metaKeywords,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CategoriesItemModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["parent_id"] is int) {
      parentId = json["parent_id"];
    }
    if (json["section_id"] is int) {
      sectionId = json["section_id"];
    }
    if (json["category_name"] is String) {
      categoryName = json["category_name"];
    }
    if (json["category_image"] is String) {
      categoryImage = json["category_image"];
    }
    if (json["category_banner_image"] is String) {
      categoryBannerImage = json["category_banner_image"];
    }
    if (json["category_discount"] is int) {
      categoryDiscount = json["category_discount"];
    }
    description = json["description"];
    if (json["url"] is String) {
      url = json["url"];
    }
    if (json["meta_title"] is String) {
      metaTitle = json["meta_title"];
    }
    if (json["meta_description"] is String) {
      metaDescription = json["meta_description"];
    }
    if (json["meta_keywords"] is String) {
      metaKeywords = json["meta_keywords"];
    }
    if (json["status"] is int) {
      status = json["status"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
  }

  static List<CategoriesItemModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(CategoriesItemModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["parent_id"] = parentId;
    _data["section_id"] = sectionId;
    _data["category_name"] = categoryName;
    _data["category_image"] = categoryImage;
    _data["category_banner_image"] = categoryBannerImage;
    _data["category_discount"] = categoryDiscount;
    _data["description"] = description;
    _data["url"] = url;
    _data["meta_title"] = metaTitle;
    _data["meta_description"] = metaDescription;
    _data["meta_keywords"] = metaKeywords;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}
