
class AddressListItemModel {
  int? id;
  int? userId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? mobile;
  int? status;
  dynamic type;
  String? createdAt;
  String? updatedAt;

  AddressListItemModel({this.id, this.userId, this.name, this.address, this.city, this.state, this.country, this.pincode, this.mobile, this.status, this.type, this.createdAt, this.updatedAt});

  AddressListItemModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
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
    if(json["status"] is int) {
      status = json["status"];
    }
    type = json["type"];
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  static List<AddressListItemModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(AddressListItemModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["name"] = name;
    _data["address"] = address;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["pincode"] = pincode;
    _data["mobile"] = mobile;
    _data["status"] = status;
    _data["type"] = type;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}