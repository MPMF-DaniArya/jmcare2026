class EsignsignRespon {
  Status? status;
  String? trxNo;
  String? psreCode;

  EsignsignRespon({this.status, this.trxNo, this.psreCode});

  EsignsignRespon.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    trxNo = json['trxNo'];
    psreCode = json['psreCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['trxNo'] = this.trxNo;
    data['psreCode'] = this.psreCode;
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


class EsignsignError extends EsignsignRespon {}