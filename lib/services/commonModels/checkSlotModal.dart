class CheckSlotModal {
  bool? status;
  String? message;
  List<String>? availableSlots;

  CheckSlotModal({this.status, this.availableSlots, this.message});

  CheckSlotModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    availableSlots = json['available_slots'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['available_slots'] = this.availableSlots;
    return data;
  }
}
