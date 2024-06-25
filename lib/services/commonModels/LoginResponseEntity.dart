import 'dart:convert';

class LoginResponseEntity {
  bool? status;
  String? message;
  User? user;
  String? token;

  LoginResponseEntity({this.status, this.message, this.user, this.token});

  LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? true; // Assuming status is true if not present
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? image;
  String? password;
  String? f_name;
  String? l_name;
  String? username;
  String? token;
  String? created_at;
  String? updated_at;

  User(
      {this.id,
        this.email,
        this.image,
        this.password,
        this.f_name,
        this.l_name,
        this.username,
        this.token,
        this.created_at,
        this.updated_at});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    f_name = json['f_name'];
    l_name = json['l_name'];
    username = json['username'];
    token = json['token'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['image'] = this.image;
    data['password'] = this.password;
    data['f_name'] = this.f_name;
    data['l_name'] = this.l_name;
    data['token'] = this.token;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
