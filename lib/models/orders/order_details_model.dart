
class OrderDetailsModel {
  int? id;
  int? userId;
  int? shippingId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? mobile;
  String? email;
  dynamic deliveryOption;
  int? shippingCharges;
  dynamic couponCode;
  dynamic couponAmount;
  String? orderStatus;
  String? paymentMethod;
  String? paymentGateway;
  int? grandTotal;
  dynamic courierName;
  String? trackingNumber;
  int? isPushed;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Products>? products;

  OrderDetailsModel({this.id, this.userId, this.shippingId, this.name, this.address, this.city, this.state, this.country, this.pincode, this.mobile, this.email, this.deliveryOption, this.shippingCharges, this.couponCode, this.couponAmount, this.orderStatus, this.paymentMethod, this.paymentGateway, this.grandTotal, this.courierName, this.trackingNumber, this.isPushed, this.createdAt, this.updatedAt, this.deletedAt, this.products});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    if(json["shipping_id"] is int) {
      shippingId = json["shipping_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["city"] is String) {
      city = json["city"];
    }
    if(json["state"] is String) {
      state = json["state"];
    }
    if(json["country"] is String) {
      country = json["country"];
    }
    if(json["pincode"] is String) {
      pincode = json["pincode"];
    }
    if(json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    deliveryOption = json["delivery_option"];
    if(json["shipping_charges"] is int) {
      shippingCharges = json["shipping_charges"];
    }
    couponCode = json["coupon_code"];
    couponAmount = json["coupon_amount"];
    if(json["order_status"] is String) {
      orderStatus = json["order_status"];
    }
    if(json["payment_method"] is String) {
      paymentMethod = json["payment_method"];
    }
    if(json["payment_gateway"] is String) {
      paymentGateway = json["payment_gateway"];
    }
    if(json["grand_total"] is int) {
      grandTotal = json["grand_total"];
    }
    courierName = json["courier_name"];
    if(json["tracking_number"] is String) {
      trackingNumber = json["tracking_number"];
    }
    if(json["is_pushed"] is int) {
      isPushed = json["is_pushed"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    if(json["products"] is List) {
      products = json["products"] == null ? null : (json["products"] as List).map((e) => Products.fromJson(e)).toList();
    }
  }

  static List<OrderDetailsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(OrderDetailsModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["shipping_id"] = shippingId;
    _data["name"] = name;
    _data["address"] = address;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["pincode"] = pincode;
    _data["mobile"] = mobile;
    _data["email"] = email;
    _data["delivery_option"] = deliveryOption;
    _data["shipping_charges"] = shippingCharges;
    _data["coupon_code"] = couponCode;
    _data["coupon_amount"] = couponAmount;
    _data["order_status"] = orderStatus;
    _data["payment_method"] = paymentMethod;
    _data["payment_gateway"] = paymentGateway;
    _data["grand_total"] = grandTotal;
    _data["courier_name"] = courierName;
    _data["tracking_number"] = trackingNumber;
    _data["is_pushed"] = isPushed;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    if(products != null) {
      _data["products"] = products?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Products {
  int? id;
  int? orderId;
  int? userId;
  int? vendorId;
  int? adminId;
  int? productId;
  String? productCode;
  String? productName;
  String? productColor;
  String? productSize;
  int? productPrice;
  int? productQty;
  dynamic itemStatus;
  dynamic courierName;
  dynamic trackingNumber;
  dynamic commission;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Products({this.id, this.orderId, this.userId, this.vendorId, this.adminId, this.productId, this.productCode, this.productName, this.productColor, this.productSize, this.productPrice, this.productQty, this.itemStatus, this.courierName, this.trackingNumber, this.commission, this.createdAt, this.updatedAt, this.imageUrl});

  Products.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["order_id"] is int) {
      orderId = json["order_id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    if(json["vendor_id"] is int) {
      vendorId = json["vendor_id"];
    }
    if(json["admin_id"] is int) {
      adminId = json["admin_id"];
    }
    if(json["product_id"] is int) {
      productId = json["product_id"];
    }
    if(json["product_code"] is String) {
      productCode = json["product_code"];
    }
    if(json["product_name"] is String) {
      productName = json["product_name"];
    }
    if(json["product_color"] is String) {
      productColor = json["product_color"];
    }
    if(json["product_size"] is String) {
      productSize = json["product_size"];
    }
    if(json["product_price"] is int) {
      productPrice = json["product_price"];
    }
    if(json["product_qty"] is int) {
      productQty = json["product_qty"];
    }
    itemStatus = json["item_status"];
    courierName = json["courier_name"];
    trackingNumber = json["tracking_number"];
    commission = json["commission"];
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if(json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
  }

  static List<Products> fromList(List<Map<String, dynamic>> list) {
    return list.map(Products.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["order_id"] = orderId;
    _data["user_id"] = userId;
    _data["vendor_id"] = vendorId;
    _data["admin_id"] = adminId;
    _data["product_id"] = productId;
    _data["product_code"] = productCode;
    _data["product_name"] = productName;
    _data["product_color"] = productColor;
    _data["product_size"] = productSize;
    _data["product_price"] = productPrice;
    _data["product_qty"] = productQty;
    _data["item_status"] = itemStatus;
    _data["courier_name"] = courierName;
    _data["tracking_number"] = trackingNumber;
    _data["commission"] = commission;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["image_url"] = imageUrl;
    return _data;
  }
}