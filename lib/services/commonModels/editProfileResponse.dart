class EditProfileResponse {
  String? message;
  bool? status;
  User? user;

  EditProfileResponse({this.message, this.status, this.user});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
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
  Null? token;
  String? createdAt;
  String? updatedAt;

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
        this.updatedAt});

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
    return data;
  }
}
