class EsignunsignedRespon {
  Status? status;
  int? totalUnsignedDocuments;

  EsignunsignedRespon({this.status, this.totalUnsignedDocuments});

  EsignunsignedRespon.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    totalUnsignedDocuments = json['totalUnsignedDocuments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['totalUnsignedDocuments'] = this.totalUnsignedDocuments;
    return data;
  }
}

class Status {
  int? code;
  String? message;

  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class EsignunsignedError extends EsignunsignedRespon{}