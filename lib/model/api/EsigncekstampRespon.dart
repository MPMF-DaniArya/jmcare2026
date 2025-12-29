class EsigncekstampRespon {
  Status? status;
  List<CheckStampingStatus>? checkStampingStatus;

  EsigncekstampRespon({this.status, this.checkStampingStatus});

  EsigncekstampRespon.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['checkStampingStatus'] != null) {
      checkStampingStatus = <CheckStampingStatus>[];
      json['checkStampingStatus'].forEach((v) {
        checkStampingStatus!.add(new CheckStampingStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.checkStampingStatus != null) {
      data['checkStampingStatus'] =
          this.checkStampingStatus!.map((v) => v.toJson()).toList();
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

class CheckStampingStatus {
  String? documentId;
  String? stampingStatus;
  String? message;

  CheckStampingStatus({this.documentId, this.stampingStatus, this.message});

  CheckStampingStatus.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    stampingStatus = json['stampingStatus'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['stampingStatus'] = this.stampingStatus;
    data['message'] = this.message;
    return data;
  }
}
class EsigncekstampError extends EsigncekstampRespon{}