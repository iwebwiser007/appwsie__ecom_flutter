
class ProductFiltersModel {
  List<String>? colors;
  List<String>? brands;
  List<String>? sizes;
  PriceRange? priceRange;

  ProductFiltersModel({this.colors, this.brands, this.sizes, this.priceRange});

  ProductFiltersModel.fromJson(Map<String, dynamic> json) {
    if(json["colors"] is List) {
      colors = json["colors"] == null ? null : List<String>.from(json["colors"]);
    }
    if(json["brands"] is List) {
      brands = json["brands"] == null ? null : List<String>.from(json["brands"]);
    }
    if(json["sizes"] is List) {
      sizes = json["sizes"] == null ? null : List<String>.from(json["sizes"]);
    }
    if(json["priceRange"] is Map) {
      priceRange = json["priceRange"] == null ? null : PriceRange.fromJson(json["priceRange"]);
    }
  }

  static List<ProductFiltersModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductFiltersModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(colors != null) {
      _data["colors"] = colors;
    }
    if(brands != null) {
      _data["brands"] = brands;
    }
    if(sizes != null) {
      _data["sizes"] = sizes;
    }
    if(priceRange != null) {
      _data["priceRange"] = priceRange?.toJson();
    }
    return _data;
  }
}

class PriceRange {
  int? min;
  int? max;

  PriceRange({this.min, this.max});

  PriceRange.fromJson(Map<String, dynamic> json) {
    if(json["min"] is int) {
      min = json["min"];
    }
    if(json["max"] is int) {
      max = json["max"];
    }
  }

  static List<PriceRange> fromList(List<Map<String, dynamic>> list) {
    return list.map(PriceRange.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["min"] = min;
    _data["max"] = max;
    return _data;
  }
}