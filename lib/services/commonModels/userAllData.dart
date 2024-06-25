class UserAllData {
  List<Services>? services;
  List<Membership>? membership;
  bool? status;
  String? message;

  UserAllData({this.services, this.membership, this.status, this.message});

  UserAllData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['membership'] != null) {
      membership = <Membership>[];
      json['membership'].forEach((v) {
        membership!.add(new Membership.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.membership != null) {
      data['membership'] = this.membership!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Services {
  int? id;
  int? appuserId;
  String? name;
  String? date;
  String? time;
  String? code;
  String? duration;
  String? price;
  String? createdAt;
  String? updatedAt;

  Services(
      {this.id,
        this.appuserId,
        this.name,
        this.date,
        this.time,
        this.code,
        this.duration,
        this.price,
        this.createdAt,
        this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appuserId = json['appuser_id'];
    name = json['name'];
    date = json['date'];
    code = json['code'];
    time = json['time'];
    duration = json['duration'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appuser_id'] = this.appuserId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['code'] = this.code;
    data['time'] = this.time;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Membership {
  int? id;
  int? appuserId;
  String? name;
  String? code;
  String? discount;
  String? activeTime;
  String? expireTime;
  String? price;
  String? createdAt;
  String? updatedAt;

  Membership(
      {this.id,
        this.appuserId,
        this.name,
        this.code,
        this.discount,
        this.activeTime,
        this.expireTime,
        this.price,
        this.createdAt,
        this.updatedAt});

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appuserId = json['appuser_id'];
    name = json['name'];
    code = json['code'];
    discount = json['discount'];
    activeTime = json['active_time'];
    expireTime = json['expire_time'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appuser_id'] = this.appuserId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['active_time'] = this.activeTime;
    data['expire_time'] = this.expireTime;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  static DateTime parseDate(String dateString) {
    List<String> parts = dateString.split(' ');
    String day = parts[0];
    String month = parts[1];
    String year = parts[2];
    String time = parts[3];

    // Convert month name to numeric
    Map<String, String> monthMap = {
      'January': '01', 'February': '02', 'March': '03',
      'April': '04', 'May': '05', 'June': '06',
      'July': '07', 'August': '08', 'September': '09',
      'October': '10', 'November': '11', 'December': '12'
    };
    String monthNumeric = monthMap[month] ?? '01'; // Default to January if not found

    // Construct date and time string in ISO 8601 format
    String isoString = '$year-$monthNumeric-$day $time';
    return DateTime.parse(isoString);
  }
}
