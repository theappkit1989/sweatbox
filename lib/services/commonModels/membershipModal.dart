class MembershipDataclass {
  bool? status;
  String? message;
  Data? data;

  MembershipDataclass({this.status, this.message, this.data});

  MembershipDataclass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? appuserId;
  String? name;
  int? discount;
  String? price;
  String? expireTime;
  String? activeTime;
  String? code;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.appuserId,
        this.name,
        this.discount,
        this.price,
        this.expireTime,
        this.activeTime,
        this.code,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    appuserId = json['appuser_id'];
    name = json['name'];
    discount = json['discount'];
    price = json['price'];
    code = json['code'];
    expireTime = json['expire_time'];
    activeTime = json['active_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appuser_id'] = this.appuserId;
    data['name'] = this.name;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['code'] = this.code;
    data['expire_time'] = this.expireTime;
    data['active_time'] = this.activeTime;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
