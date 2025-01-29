
class BannersModel {
  int? id;
  String? image;
  String? type;
  String? title;
  String? alt;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  BannersModel({this.id, this.image, this.type, this.title, this.alt, this.status, this.createdAt, this.updatedAt, this.deletedAt});

  BannersModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["alt"] is String) {
      alt = json["alt"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if(json["deleted_at"] is String) {
      deletedAt = json["deleted_at"];
    }
  }

  static List<BannersModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(BannersModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image"] = image;
    _data["type"] = type;
    _data["title"] = title;
    _data["alt"] = alt;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}