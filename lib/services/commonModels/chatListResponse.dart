import 'dart:ffi';

class ChatListResponse {
  bool? status;
  String? message;
  List<Chats>? response;

  ChatListResponse({this.status, this.message, this.response});

  ChatListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = <Chats>[];
      json['response'].forEach((v) {
        response!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  int? id;
  String? email;
  String? image;
  int? isNewMessage;
  String? password;
  String? fName;
  String? lName;
  String? username;
  int? status;
  String? token;
  String? createdAt;
  String? updatedAt;
  String? socket;
  String? lastMessage;
  String? lastMessageTime;

  Chats(
      {this.id,
        this.email,
        this.image,
        this.password,
        this.fName,
        this.lName,
        this.username,
        this.isNewMessage,
        this.status,
        this.token,
        this.createdAt,
        this.updatedAt,
        this.socket,
        this.lastMessage,
        this.lastMessageTime});

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    username = json['username'];
    status = json['status'];
    isNewMessage = json['is_new'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    socket = json['socket'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['image'] = this.image;
    data['password'] = this.password;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['is_new'] = this.isNewMessage;
    data['username'] = this.username;
    data['status'] = this.status;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['socket'] = this.socket;
    data['last_message'] = this.lastMessage;
    data['last_message_time'] = this.lastMessageTime;
    return data;
  }
}
