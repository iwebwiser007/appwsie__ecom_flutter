
class UserCartItems {
  int? id;
  dynamic sessionId;
  int? userId;
  int? productId;
  String? size;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  ProductDetails? productDetails;

  UserCartItems({this.id, this.sessionId, this.userId, this.productId, this.size, this.quantity, this.createdAt, this.updatedAt, this.productDetails});

  UserCartItems.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    sessionId = json["session_id"];
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    if(json["product_id"] is int) {
      productId = json["product_id"];
    }
    if(json["size"] is String) {
      size = json["size"];
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if(json["productDetails"] is Map) {
      productDetails = json["productDetails"] == null ? null : ProductDetails.fromJson(json["productDetails"]);
    }
  }

  static List<UserCartItems> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserCartItems.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["session_id"] = sessionId;
    _data["user_id"] = userId;
    _data["product_id"] = productId;
    _data["size"] = size;
    _data["quantity"] = quantity;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if(productDetails != null) {
      _data["productDetails"] = productDetails?.toJson();
    }
    return _data;
  }
}

class ProductDetails {
  int? id;
  String? productName;
  int? productPrice;
  String? productImage;
  String? productCode;

  ProductDetails({this.id, this.productName, this.productPrice, this.productImage, this.productCode});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["product_name"] is String) {
      productName = json["product_name"];
    }
    if(json["product_price"] is int) {
      productPrice = json["product_price"];
    }
    if(json["product_image"] is String) {
      productImage = json["product_image"];
    }
    if(json["product_code"] is String) {
      productCode = json["product_code"];
    }
  }

  static List<ProductDetails> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductDetails.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["product_name"] = productName;
    _data["product_price"] = productPrice;
    _data["product_image"] = productImage;
    _data["product_code"] = productCode;
    return _data;
  }
}