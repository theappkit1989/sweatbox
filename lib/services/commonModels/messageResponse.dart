class MessageResponse {
  bool? success;
  String? message;
  List<MessageData>? response;

  MessageResponse({this.success, this.message, this.response});

  MessageResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['response'] != null) {
      response = <MessageData>[];
      json['response'].forEach((v) {
        response!.add(new MessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageData {
  int? id;
  String? senderId;
  String? receiverId;
  String? status;
  String? message;
  String? createdAt;
  String? updatedAt;
  String? type;

  MessageData(
      {this.id,
        this.senderId,
        this.receiverId,
        this.status,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.type});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    status = json['status'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['status'] = this.status;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    return data;
  }
}
