class MpmiBaseRespon {
  String? status;
  String? token;
  String? message;

  MpmiBaseRespon({this.status, this.token, this.message});

  MpmiBaseRespon.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
class MpmibaseError extends MpmiBaseRespon{}