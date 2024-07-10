class MessageResponse {
  bool? success;
  String? message;
  List<MessageData>? response;

  MessageResponse({
    this.success,
    this.message,
    this.response,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      success: json['success'],
      message: json['message'],
      response: json['response'] != null
          ? List<MessageData>.from(json['response'].map((v) => MessageData.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'response': response?.map((v) => v.toJson()).toList(),
    };
  }
}

class MessageData {
  dynamic? senderId;
  dynamic? receiverId;
  String? message;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  MessageData({
    this.senderId,
    this.receiverId,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'],
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'id': id,
    };
  }
}
