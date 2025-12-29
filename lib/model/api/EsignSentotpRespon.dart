class EsignSentotpRespon {
  Status? status;
  String? trxNo;
  String? otpByEmail;
  String? psreCode;

  EsignSentotpRespon({this.status, this.trxNo, this.otpByEmail, this.psreCode});

  EsignSentotpRespon.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    trxNo = json['trxNo'];
    otpByEmail = json['otpByEmail'];
    psreCode = json['psreCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['trxNo'] = this.trxNo;
    data['otpByEmail'] = this.otpByEmail;
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
class EsignsentotpError extends EsignSentotpRespon{}