// class CommonResponseEntity {
//   dynamic? code;
//   bool? status;
//   String? message;
//   String? token;
//   String? data;
//   UserData? userData;
//
//
//
//   CommonResponseEntity({this.code, this.message,this.status,this.userData});
//
//   CommonResponseEntity.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     token = json['access_token'];
//     if(json['data']!=null && (json['data'] is String)) {
//       data = json['data'];
//     } else {
//       userData = json['data'] != null ? new UserData.fromJson(json['data']) : null;
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class UserData {
//   int? id;
//   String? name;
//   String? lastName;
//   String? email;
//   String? emailVerifiedAt;
//   String? userType;
//   String? profileImg;
//   String? deviceKey;
//   String? createdAt;
//   String? updatedAt;
//
//   UserData(
//       {this.id,
//         this.name,
//         this.lastName,
//         this.email,
//         this.emailVerifiedAt,
//         this.userType,
//         this.profileImg,
//         this.deviceKey,
//         this.createdAt,
//         this.updatedAt});
//
//   UserData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     userType = json['user_type'];
//     profileImg = json['profile_img'];
//     deviceKey = json['device_key'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['user_type'] = this.userType;
//     data['profile_img'] = this.profileImg;
//     data['device_key'] = this.deviceKey;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
class CommonResponseEntity {
  String? message;
  int? user_id;
  bool? status;
  User? user;
  String? accessToken;
  String? tokenType;

  CommonResponseEntity({this.message,this.user_id, this.status, this.user, this.accessToken, this.tokenType});

  CommonResponseEntity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user_id = json['user_id'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }
}

class User {
  int? id;
  String? fName;
  String? lName;
  String? image;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.fName, this.lName, this.image, this.username, this.email, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}