class PromoCodeResponse {
  List<Promo>? promo;
  bool? status;
  String? message;

  PromoCodeResponse({this.promo, this.status, this.message});

  PromoCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['promo'] != null) {
      promo = <Promo>[];
      json['promo'].forEach((v) {
        promo!.add(new Promo.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promo != null) {
      data['promo'] = this.promo!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Promo {
  int? id;
  String? promo;
  String? discount;
  String? category;
  String? createdAt;
  String? updatedAt;

  Promo(
      {this.id,
        this.promo,
        this.discount,
        this.category,
        this.createdAt,
        this.updatedAt});

  Promo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    promo = json['promo'];
    discount = json['discount'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['promo'] = this.promo;
    data['discount'] = this.discount;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
