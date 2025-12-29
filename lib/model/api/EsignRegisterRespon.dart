class EsignRegisterRespon {
  Status? status;
  List<String>? trxNo;
  bool? verifStatus;
  Results? results;
  String? psreCode;

  EsignRegisterRespon(
      {this.status,
      this.trxNo,
      this.verifStatus,
      this.results,
      this.psreCode});

  EsignRegisterRespon.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null
        ? new Status.fromJson(json['status'])
        : null;
    trxNo = json['trxNo'] != null ? json['trxNo'].cast<String>() : null;
    verifStatus = json['verifStatus'] != null ? json['verifStatus'] : null;
    results = json['results'] != null
        ? new Results.fromJson(json['results'])
        : null;
    psreCode = json['psreCode'] != null ? json['psreCode'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['trxNo'] = this.trxNo;
    data['verifStatus'] = this.verifStatus;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
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

class Results {
  String? nik;
  String? name;
  String? birthDate;
  String? liveness;
  String? selfieCheck;
  String? selfieSimilarity;

  Results(
      {this.nik,
      this.name,
      this.birthDate,
      this.liveness,
      this.selfieCheck,
      this.selfieSimilarity});

  Results.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    name = json['name'];
    birthDate = json['birthDate'];
    liveness = json['liveness'];
    selfieCheck = json['selfieCheck'];
    selfieSimilarity = json['selfieSimilarity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nik'] = this.nik;
    data['name'] = this.name;
    data['birthDate'] = this.birthDate;
    data['liveness'] = this.liveness;
    data['selfieCheck'] = this.selfieCheck;
    data['selfieSimilarity'] = this.selfieSimilarity;
    return data;
  }
}

class EsignregisterError extends EsignRegisterRespon {}
