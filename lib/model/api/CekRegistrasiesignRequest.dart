class CekRegistrasiesignRequest {
  Audit? audit;
  String? dataType;
  String? userData;

  CekRegistrasiesignRequest({this.audit, this.dataType, this.userData});

  CekRegistrasiesignRequest.fromJson(Map<String, dynamic> json) {
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    dataType = json['dataType'];
    userData = json['userData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    data['dataType'] = this.dataType;
    data['userData'] = this.userData;
    return data;
  }
}

class Audit {
  String? callerId;

  Audit({this.callerId});

  Audit.fromJson(Map<String, dynamic> json) {
    callerId = json['callerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callerId'] = this.callerId;
    return data;
  }
}
