class OrdersListItemModel {
  int? orderNumber;
  String? date;
  String? trackingNumber;
  int? totalAmount;
  int? quantity;
  String? status;

  OrdersListItemModel({
    this.orderNumber,
    this.date,
    this.trackingNumber,
    this.totalAmount,
    this.quantity,
    this.status,
  });

  OrdersListItemModel.fromJson(Map<String, dynamic> json) {
    if (json["order_number"] is int) {
      orderNumber = json["order_number"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["tracking_number"] is String) {
      trackingNumber = json["tracking_number"];
    }
    if (json["total_amount"] is int) {
      totalAmount = json["total_amount"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
  }

  static List<OrdersListItemModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(OrdersListItemModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["order_number"] = orderNumber;
    _data["date"] = date;
    _data["tracking_number"] = trackingNumber;
    _data["total_amount"] = totalAmount;
    _data["quantity"] = quantity;
    _data["status"] = status;
    return _data;
  }
}
