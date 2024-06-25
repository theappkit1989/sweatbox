class ServiceDataClass {
  bool? status;
  String? message;
  Data? data;

  ServiceDataClass({this.status, this.message, this.data});

  ServiceDataClass.fromJson(Map<String, dynamic> json) {
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
  String? price;
  String? date;
  String? time;
  String? code;
  String? duration;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.appuserId,
        this.name,
        this.price,
        this.date,
        this.time,
        this.code,
        this.duration,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    appuserId = json['appuser_id'];
    name = json['name'];
    price = json['price'];
    date = json['date'];
    code = json['code'];
    time = json['time'];
    duration = json['duration'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appuser_id'] = this.appuserId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['date'] = this.date;
    data['code'] = this.code;
    data['time'] = this.time;
    data['duration'] = this.duration;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
