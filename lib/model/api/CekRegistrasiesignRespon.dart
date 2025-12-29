class CekRegistrasiesignRespon {
  Status? status;
  List<RegistrationData>? registrationData;

  CekRegistrasiesignRespon({this.status, this.registrationData});

  CekRegistrasiesignRespon.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['registrationData'] != null) {
      registrationData = <RegistrationData>[];
      json['registrationData'].forEach((v) {
        registrationData!.add(new RegistrationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.registrationData != null) {
      data['registrationData'] =
          this.registrationData!.map((v) => v.toJson()).toList();
    }
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

class RegistrationData {
  String? vendor;
  String? registrationStatus;

  RegistrationData({this.vendor, this.registrationStatus});

  RegistrationData.fromJson(Map<String, dynamic> json) {
    vendor = json['vendor'];
    registrationStatus = json['registrationStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor'] = this.vendor;
    data['registrationStatus'] = this.registrationStatus;
    return data;
  }
}

class CekregistrasiesignError extends CekRegistrasiesignRespon {}
