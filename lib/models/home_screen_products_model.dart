class HomeScreenProductsModel {
  Featured? featured;
  Featured? bestseller;
  Featured? newArrivals;
  Featured? hotDeals;

  HomeScreenProductsModel({this.featured, this.bestseller, this.newArrivals, this.hotDeals});

  HomeScreenProductsModel.fromJson(Map<String, dynamic> json) {
    featured = json['featured'] != null ? Featured.fromJson(json['featured']) : null;
    bestseller = json['bestseller'] != null ? Featured.fromJson(json['bestseller']) : null;
    newArrivals = json['newArrivals'] != null ? Featured.fromJson(json['newArrivals']) : null;
    hotDeals = json['hotDeals'] != null ? Featured.fromJson(json['hotDeals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (featured != null) {
      data['featured'] = featured!.toJson();
    }
    if (bestseller != null) {
      data['bestseller'] = bestseller!.toJson();
    }
    if (newArrivals != null) {
      data['newArrivals'] = newArrivals!.toJson();
    }
    if (hotDeals != null) {
      data['hotDeals'] = hotDeals!.toJson();
    }
    return data;
  }
}

class Featured {
  List<Product>? products;
  int? total;
  int? totalPages;
  int? currentPage;

  Featured({this.products, this.total, this.totalPages, this.currentPage});

  Featured.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    return data;
  }
}

class Product {
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
  String? test;
  String? filtercolumn;
  String? mini;
  String? testfiltername;
  String? length;
  String? cableLenght;
  String? jkdscbj;
  String? tShirt;
  String? name;
  String? operatingSystem;
  String? screenSize;
  String? occasion;
  String? fit;
  String? pattern;
  String? sleeve;
  String? ram;
  String? fabric;
  String? metaTitle;
  String? metaDescription;
  dynamic isFeatured;
  dynamic isBestseller;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Product(
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
      this.deletedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    vendorId = json['vendor_id'];
    adminId = json['admin_id'];
    adminType = json['admin_type'];
    productName = json['product_name'];
    productCode = json['product_code'];
    productColor = json['product_color'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productWeight = json['product_weight'];
    productLength = json['product_length'];
    productWidth = json['product_width'];
    productHeight = json['product_height'];
    productImage = json['product_image'];
    productVideo = json['product_video'];
    groupCode = json['group_code'];
    description = json['description'];
    test = json['test'];
    filtercolumn = json['filtercolumn'];
    mini = json['mini'];
    testfiltername = json['testfiltername'];
    length = json['length'];
    cableLenght = json['cable_lenght'];
    jkdscbj = json['jkdscbj'];
    tShirt = json['t_shirt'];
    name = json['name'];
    operatingSystem = json['operating_system'];
    screenSize = json['screen_size'];
    occasion = json['occasion'];
    fit = json['fit'];
    pattern = json['pattern'];
    sleeve = json['sleeve'];
    ram = json['ram'];
    fabric = json['fabric'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    isFeatured = json['is_featured'];
    isBestseller = json['is_bestseller'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['category_id'] = categoryId;
    data['brand_id'] = brandId;
    data['vendor_id'] = vendorId;
    data['admin_id'] = adminId;
    data['admin_type'] = adminType;
    data['product_name'] = productName;
    data['product_code'] = productCode;
    data['product_color'] = productColor;
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_weight'] = productWeight;
    data['product_length'] = productLength;
    data['product_width'] = productWidth;
    data['product_height'] = productHeight;
    data['product_image'] = productImage;
    data['product_video'] = productVideo;
    data['group_code'] = groupCode;
    data['description'] = description;
    data['test'] = test;
    data['filtercolumn'] = filtercolumn;
    data['mini'] = mini;
    data['testfiltername'] = testfiltername;
    data['length'] = length;
    data['cable_lenght'] = cableLenght;
    data['jkdscbj'] = jkdscbj;
    data['t_shirt'] = tShirt;
    data['name'] = name;
    data['operating_system'] = operatingSystem;
    data['screen_size'] = screenSize;
    data['occasion'] = occasion;
    data['fit'] = fit;
    data['pattern'] = pattern;
    data['sleeve'] = sleeve;
    data['ram'] = ram;
    data['fabric'] = fabric;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['is_featured'] = isFeatured;
    data['is_bestseller'] = isBestseller;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
