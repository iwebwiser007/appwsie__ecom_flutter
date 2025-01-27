
class UserDataModel {
  int? id;
  String? name;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic pincode;
  int? mobile;
  String? email;
  dynamic emailVerifiedAt;
  String? password;
  dynamic status;
  dynamic rememberToken;
  dynamic accessToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  UserDataModel({this.id, this.name, this.address, this.city, this.state, this.country, this.pincode, this.mobile, this.email, this.emailVerifiedAt, this.password, this.status, this.rememberToken, this.accessToken, this.createdAt, this.updatedAt, this.deletedAt});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    address = json["address"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    pincode = json["pincode"];
    if(json["mobile"] is int) {
      mobile = json["mobile"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    emailVerifiedAt = json["email_verified_at"];
    if(json["password"] is String) {
      password = json["password"];
    }
    status = json["status"];
    rememberToken = json["remember_token"];
    accessToken = json["access_token"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    deletedAt = json["deleted_at"];
  }

  static List<UserDataModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserDataModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["address"] = address;
    _data["city"] = city;
    _data["state"] = state;
    _data["country"] = country;
    _data["pincode"] = pincode;
    _data["mobile"] = mobile;
    _data["email"] = email;
    _data["email_verified_at"] = emailVerifiedAt;
    _data["password"] = password;
    _data["status"] = status;
    _data["remember_token"] = rememberToken;
    _data["access_token"] = accessToken;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}