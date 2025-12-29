class AgreementinscoRespon {
  List<Data>? data;

  AgreementinscoRespon({this.data});

  AgreementinscoRespon.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? aGRMNTNO;
  String? cONTRACTSTAT;
  String? iNSCOBRANCHNAME;
  String? mAINCVGTYPENAME;
  String? oFFICECODE;
  String? pOLICYNAME;
  String? pOLICYNO;

  Data(
      {this.aGRMNTNO,
        this.cONTRACTSTAT,
        this.iNSCOBRANCHNAME,
        this.mAINCVGTYPENAME,
        this.oFFICECODE,
        this.pOLICYNAME,
        this.pOLICYNO});

  Data.fromJson(Map<String, dynamic> json) {
    aGRMNTNO = json['AGRMNT_NO'];
    cONTRACTSTAT = json['CONTRACT_STAT'];
    iNSCOBRANCHNAME = json['INSCO_BRANCH_NAME'];
    mAINCVGTYPENAME = json['MAIN_CVG_TYPE_NAME'];
    oFFICECODE = json['OFFICE_CODE'];
    pOLICYNAME = json['POLICY_NAME'];
    pOLICYNO = json['POLICY_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AGRMNT_NO'] = this.aGRMNTNO;
    data['CONTRACT_STAT'] = this.cONTRACTSTAT;
    data['INSCO_BRANCH_NAME'] = this.iNSCOBRANCHNAME;
    data['MAIN_CVG_TYPE_NAME'] = this.mAINCVGTYPENAME;
    data['OFFICE_CODE'] = this.oFFICECODE;
    data['POLICY_NAME'] = this.pOLICYNAME;
    data['POLICY_NO'] = this.pOLICYNO;
    return data;
  }
}

class AgreementinscoError extends AgreementinscoRespon{}