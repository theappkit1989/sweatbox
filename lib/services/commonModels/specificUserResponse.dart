import 'dart:async';

class SpecificUserResponse {
  bool? status;
  String? message;
  User? user;

  SpecificUserResponse({this.status,this.message, this.user});

  SpecificUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? image;
  String? password;
  String? fName;
  String? lName;
  String? username;
  int? status;
  String? token;
  String? createdAt;
  String? updatedAt;
  String? socket;

  User(
      {this.id,
        this.email,
        this.image,
        this.password,
        this.fName,
        this.lName,
        this.username,
        this.status,
        this.token,
        this.createdAt,
        this.updatedAt,
        this.socket});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    username = json['username'];
    status = json['status'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    socket = json['socket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['image'] = this.image;
    data['password'] = this.password;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['username'] = this.username;
    data['status'] = this.status;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['socket'] = this.socket;
    return data;
  }
}
