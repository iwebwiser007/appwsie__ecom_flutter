class ProductDetailsModel {
  int? id;
  int? sectionId;
  int? categoryId;
  int? brandId;
  int? vendorId;
  int? adminId;
  String? adminType;
  String? productName;
  String? productCode;
  String? productColor;
  int? productPrice;
  int? productDiscount;
  int? productWeight;
  int? productLength;
  int? productWidth;
  int? productHeight;
  String? productImage;
  String? productVideo;
  String? groupCode;
  String? description;
  dynamic test;
  dynamic filtercolumn;
  dynamic mini;
  dynamic testfiltername;
  dynamic length;
  dynamic cableLenght;
  dynamic jkdscbj;
  dynamic tShirt;
  dynamic name;
  dynamic operatingSystem;
  dynamic screenSize;
  dynamic occasion;
  dynamic fit;
  dynamic pattern;
  dynamic sleeve;
  dynamic ram;
  dynamic fabric;
  String? metaTitle;
  String? metaDescription;
  int? isFeatured;
  int? isBestseller;
  String? createdAt;
  String? updatedAt;
  bool? isWishlisted;
  int? averageRating;
  bool? alreadyinCart;
  dynamic deletedAt;
  List<Brand>? brand;
  List<Attributes>? attributes;
  List<Ratings>? ratings;
  List<ProductColor>? colors;

  ProductDetailsModel(
      {this.id,
      this.sectionId,
      this.categoryId,
      this.brandId,
      this.vendorId,
      this.adminId,
      this.adminType,
      this.productName,
      this.productCode,
      this.productColor,
      this.productPrice,
      this.productDiscount,
      this.productWeight,
      this.productLength,
      this.productWidth,
      this.productHeight,
      this.productImage,
      this.productVideo,
      this.groupCode,
      this.description,
      this.test,
      this.filtercolumn,
      this.mini,
      this.testfiltername,
      this.length,
      this.cableLenght,
      this.jkdscbj,
      this.tShirt,
      this.name,
      this.operatingSystem,
      this.screenSize,
      this.occasion,
      this.fit,
      this.pattern,
      this.sleeve,
      this.ram,
      this.fabric,
      this.metaTitle,
      this.metaDescription,
      this.isFeatured,
      this.isBestseller,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.brand,
      this.attributes,
      this.isWishlisted,
      this.alreadyinCart,
      this.averageRating,
      this.ratings,
      this.colors});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["section_id"] is int) {
      sectionId = json["section_id"];
    }
    if (json["category_id"] is int) {
      categoryId = json["category_id"];
    }
    if (json["brand_id"] is int) {
      brandId = json["brand_id"];
    }
    if (json["vendor_id"] is int) {
      vendorId = json["vendor_id"];
    }
    if (json["admin_id"] is int) {
      adminId = json["admin_id"];
    }
    if (json["admin_type"] is String) {
      adminType = json["admin_type"];
    }
    if (json["product_name"] is String) {
      productName = json["product_name"];
    }
    if (json["product_code"] is String) {
      productCode = json["product_code"];
    }
    if (json["product_color"] is String) {
      productColor = json["product_color"];
    }
    if (json["product_price"] is int) {
      productPrice = json["product_price"];
    }
    if (json["product_discount"] is int) {
      productDiscount = json["product_discount"];
    }
    if (json["averageRating"] is int) {
      averageRating = json["averageRating"];
    }
    if (json["isWishlisted"] is bool) {
      isWishlisted = json["isWishlisted"];
    }
    if (json["alreadyinCart"] is bool) {
      alreadyinCart = json["alreadyinCart"];
    }
    if (json["product_weight"] is int) {
      productWeight = json["product_weight"];
    }
    if (json["product_length"] is int) {
      productLength = json["product_length"];
    }
    if (json["product_width"] is int) {
      productWidth = json["product_width"];
    }
    if (json["product_height"] is int) {
      productHeight = json["product_height"];
    }
    if (json["product_image"] is String) {
      productImage = json["product_image"];
    }
    if (json["product_video"] is String) {
      productVideo = json["product_video"];
    }
    if (json["group_code"] is String) {
      groupCode = json["group_code"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    test = json["test"];
    filtercolumn = json["filtercolumn"];
    mini = json["mini"];
    testfiltername = json["testfiltername"];
    length = json["length"];
    cableLenght = json["cable_lenght"];
    jkdscbj = json["jkdscbj"];
    tShirt = json["t_shirt"];
    name = json["name"];
    operatingSystem = json["operating_system"];
    screenSize = json["screen_size"];
    occasion = json["occasion"];
    fit = json["fit"];
    pattern = json["pattern"];
    sleeve = json["sleeve"];
    ram = json["ram"];
    fabric = json["fabric"];
    if (json["meta_title"] is String) {
      metaTitle = json["meta_title"];
    }
    if (json["meta_description"] is String) {
      metaDescription = json["meta_description"];
    }
    if (json["is_featured"] is int) {
      isFeatured = json["is_featured"];
    }
    if (json["is_bestseller"] is int) {
      isBestseller = json["is_bestseller"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    if (json["brand"] is List) {
      brand = json["brand"] == null ? null : (json["brand"] as List).map((e) => Brand.fromJson(e)).toList();
    }
    if (json["attributes"] is List) {
      attributes = json["attributes"] == null ? null : (json["attributes"] as List).map((e) => Attributes.fromJson(e)).toList();
    }
    if (json["ratings"] is List) {
      ratings = json["ratings"] == null ? null : (json["ratings"] as List).map((e) => Ratings.fromJson(e)).toList();
    }
    if (json["colors"] is List) {
      colors = json["colors"] == null ? null : (json["colors"] as List).map((e) => ProductColor.fromJson(e)).toList();
    }
  }

  static List<ProductDetailsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductDetailsModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["section_id"] = sectionId;
    _data["category_id"] = categoryId;
    _data["brand_id"] = brandId;
    _data["vendor_id"] = vendorId;
    _data["admin_id"] = adminId;
    _data["admin_type"] = adminType;
    _data["product_name"] = productName;
    _data["product_code"] = productCode;
    _data["product_color"] = productColor;
    _data["product_price"] = productPrice;
    _data["product_discount"] = productDiscount;
    _data["product_weight"] = productWeight;
    _data["product_length"] = productLength;
    _data["product_width"] = productWidth;
    _data["product_height"] = productHeight;
    _data["product_image"] = productImage;
    _data["product_video"] = productVideo;
    _data["group_code"] = groupCode;
    _data["description"] = description;
    _data["test"] = test;
    _data["filtercolumn"] = filtercolumn;
    _data["mini"] = mini;
    _data["testfiltername"] = testfiltername;
    _data["length"] = length;
    _data["cable_lenght"] = cableLenght;
    _data["jkdscbj"] = jkdscbj;
    _data["t_shirt"] = tShirt;
    _data["name"] = name;
    _data["operating_system"] = operatingSystem;
    _data["screen_size"] = screenSize;
    _data["occasion"] = occasion;
    _data["fit"] = fit;
    _data["pattern"] = pattern;
    _data["sleeve"] = sleeve;
    _data["ram"] = ram;
    _data["fabric"] = fabric;
    _data["meta_title"] = metaTitle;
    _data["meta_description"] = metaDescription;
    _data["is_featured"] = isFeatured;
    _data["is_bestseller"] = isBestseller;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    _data["alreadyinCart"] = alreadyinCart;
    _data["isWishlisted"] = isWishlisted;
    _data["averageRating"] = averageRating;
    if (brand != null) {
      _data["brand"] = brand?.map((e) => e.toJson()).toList();
    }
    if (attributes != null) {
      _data["attributes"] = attributes?.map((e) => e.toJson()).toList();
    }
    if (ratings != null) {
      _data["ratings"] = ratings?.map((e) => e.toJson()).toList();
    }
    if (colors != null) {
      _data["colors"] = colors?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ProductColor {
  String? color;
  String? image;
  int? productId;

  ProductColor({this.color, this.image, this.productId});

  ProductColor.fromJson(Map<String, dynamic> json) {
    if (json["color"] is String) {
      color = json["color"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["product_id"] is int) {
      productId = json["product_id"];
    }
  }

  static List<ProductColor> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductColor.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["color"] = color;
    _data["image"] = image;
    _data["product_id"] = productId;
    return _data;
  }
}

class Ratings {
  int? id;
  int? userId;
  int? productId;
  String? review;
  int? rating;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  List<dynamic>? images;

  Ratings({
    this.id,
    this.userId,
    this.productId,
    this.review,
    this.rating,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.images,
  });

  Ratings.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["product_id"] is int) {
      productId = json["product_id"];
    }
    if (json["review"] is String) {
      review = json["review"];
    }
    if (json["rating"] is int) {
      rating = json["rating"];
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
    if (json["deleted_at"] is String) {
      deletedAt = json["deleted_at"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["images"] is List) {
      images = json["images"] ?? [];
    }
  }

  static List<Ratings> fromList(List<Map<String, dynamic>> list) {
    return list.map(Ratings.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["product_id"] = productId;
    _data["review"] = review;
    _data["rating"] = rating;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    _data["name"] = name;
    if (images != null) {
      _data["images"] = images;
    }
    return _data;
  }
}

class Attributes {
  int? id;
  int? productId;
  dynamic attributeId;
  String? size;
  int? price;
  int? stock;
  String? sku;
  int? status;
  String? createdAt;
  String? updatedAt;

  Attributes({this.id, this.productId, this.attributeId, this.size, this.price, this.stock, this.sku, this.status, this.createdAt, this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["product_id"] is int) {
      productId = json["product_id"];
    }
    attributeId = json["attribute_id"];
    if (json["size"] is String) {
      size = json["size"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["stock"] is int) {
      stock = json["stock"];
    }
    if (json["sku"] is String) {
      sku = json["sku"];
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
  }

  static List<Attributes> fromList(List<Map<String, dynamic>> list) {
    return list.map(Attributes.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["product_id"] = productId;
    _data["attribute_id"] = attributeId;
    _data["size"] = size;
    _data["price"] = price;
    _data["stock"] = stock;
    _data["sku"] = sku;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

class Brand {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Brand({this.id, this.name, this.status, this.createdAt, this.updatedAt, this.deletedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
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

  static List<Brand> fromList(List<Map<String, dynamic>> list) {
    return list.map(Brand.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}
