class EsignstatussignRespon {
  Status? status;
  List<StatusSigning>? statusSigning;

  EsignstatussignRespon({this.status, this.statusSigning});

  EsignstatussignRespon.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['statusSigning'] != null) {
      statusSigning = <StatusSigning>[];
      json['statusSigning'].forEach((v) {
        statusSigning!.add(new StatusSigning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.statusSigning != null) {
      data['statusSigning'] =
          this.statusSigning!.map((v) => v.toJson()).toList();
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

class StatusSigning {
  String? documentId;
  List<Signer>? signer;

  StatusSigning({this.documentId, this.signer});

  StatusSigning.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    if (json['signer'] != null) {
      signer = <Signer>[];
      json['signer'].forEach((v) {
        signer!.add(new Signer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    if (this.signer != null) {
      data['signer'] = this.signer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Signer {
  String? email;
  String? phoneNo;
  String? name;
  String? signStatus;

  Signer({this.email, this.phoneNo, this.name, this.signStatus});

  Signer.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNo = json['phoneNo'];
    name = json['name'];
    signStatus = json['signStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['name'] = this.name;
    data['signStatus'] = this.signStatus;
    return data;
  }
}


class EsignstatussignError extends EsignstatussignRespon{}