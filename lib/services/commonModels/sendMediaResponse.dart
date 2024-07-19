class SendMediaResponse {
  bool? status;
  String? path;
  String? message;

  SendMediaResponse({this.status, this.path, this.message});

  SendMediaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    path = json['path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['path'] = this.path;
    data['message'] = this.message;
    return data;
  }
}
