class JenisklaimRespon {
  List<Data>? data;

  JenisklaimRespon({this.data});

  JenisklaimRespon.fromJson(Map<String, dynamic> json) {
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
  String? dTMCRT;
  String? dTMUPD;
  String? iSACTIVE;
  String? iSSYSTEM;
  String? rEASONCODE;
  String? rEASONDESCR;
  String? rEFREASONID;
  String? rEFREASONTYPECODE;
  String? uSRCRT;
  String? uSRUPD;

  Data(
      {this.dTMCRT,
        this.dTMUPD,
        this.iSACTIVE,
        this.iSSYSTEM,
        this.rEASONCODE,
        this.rEASONDESCR,
        this.rEFREASONID,
        this.rEFREASONTYPECODE,
        this.uSRCRT,
        this.uSRUPD});

  Data.fromJson(Map<String, dynamic> json) {
    dTMCRT = json['DTM_CRT'];
    dTMUPD = json['DTM_UPD'];
    iSACTIVE = json['IS_ACTIVE'];
    iSSYSTEM = json['IS_SYSTEM'];
    rEASONCODE = json['REASON_CODE'];
    rEASONDESCR = json['REASON_DESCR'];
    rEFREASONID = json['REF_REASON_ID'];
    rEFREASONTYPECODE = json['REF_REASON_TYPE_CODE'];
    uSRCRT = json['USR_CRT'];
    uSRUPD = json['USR_UPD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DTM_CRT'] = this.dTMCRT;
    data['DTM_UPD'] = this.dTMUPD;
    data['IS_ACTIVE'] = this.iSACTIVE;
    data['IS_SYSTEM'] = this.iSSYSTEM;
    data['REASON_CODE'] = this.rEASONCODE;
    data['REASON_DESCR'] = this.rEASONDESCR;
    data['REF_REASON_ID'] = this.rEFREASONID;
    data['REF_REASON_TYPE_CODE'] = this.rEFREASONTYPECODE;
    data['USR_CRT'] = this.uSRCRT;
    data['USR_UPD'] = this.uSRUPD;
    return data;
  }
}
class JenisklaimError extends JenisklaimRespon{}