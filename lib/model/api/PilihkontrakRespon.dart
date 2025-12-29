class PilihkontrakRespon {
  List<Data>? data;

  PilihkontrakRespon({this.data});

  PilihkontrakRespon.fromJson(Map<String, dynamic> json) {
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
  int? aGRMNTID;
  String? cUSTFULLNAME;
  String? iDNO;
  String? aGRMNTNO;
  String? sERIALNO1;
  String? sERIALNO2;
  String? mANUFACTURINGYEAR;
  String? pLATNO;
  String? kTPNO;
  String? merkType;
  String? warna;
  double? estimasiAngsuran;
  int? keterlambatanHari;
  double? denda;
  String? aPPNO;
  String? oFFICECODE;
  String? oFFICENAME;
  String? tGLGOLIVE;
  String? uSIAGOLIVE;

  Data(
      {this.aGRMNTID,
        this.cUSTFULLNAME,
        this.iDNO,
        this.aGRMNTNO,
        this.sERIALNO1,
        this.sERIALNO2,
        this.mANUFACTURINGYEAR,
        this.pLATNO,
        this.kTPNO,
        this.merkType,
        this.warna,
        this.estimasiAngsuran,
        this.keterlambatanHari,
        this.denda,
        this.aPPNO,
        this.oFFICECODE,
        this.oFFICENAME,
        this.tGLGOLIVE,
        this.uSIAGOLIVE});

  Data.fromJson(Map<String, dynamic> json) {
    aGRMNTID = json['AGRMNT_ID'];
    cUSTFULLNAME = json['CUST_FULL_NAME'];
    iDNO = json['ID_NO'];
    aGRMNTNO = json['AGRMNT_NO'];
    sERIALNO1 = json['SERIAL_NO_1'];
    sERIALNO2 = json['SERIAL_NO_2'];
    mANUFACTURINGYEAR = json['MANUFACTURING_YEAR'];
    pLATNO = json['PLAT_NO'];
    kTPNO = json['KTPNO'];
    merkType = json['merk_type'];
    warna = json['warna'];
    estimasiAngsuran = json['estimasi_angsuran'];
    keterlambatanHari = json['keterlambatan_hari'];
    denda = json['Denda'];
    aPPNO = json['APP_NO'];
    oFFICECODE = json['OFFICE_CODE'];
    oFFICENAME = json['OFFICE_NAME'];
    tGLGOLIVE = json['TGL_GOLIVE'];
    uSIAGOLIVE = json['USIA_GOLIVE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AGRMNT_ID'] = this.aGRMNTID;
    data['CUST_FULL_NAME'] = this.cUSTFULLNAME;
    data['ID_NO'] = this.iDNO;
    data['AGRMNT_NO'] = this.aGRMNTNO;
    data['SERIAL_NO_1'] = this.sERIALNO1;
    data['SERIAL_NO_2'] = this.sERIALNO2;
    data['MANUFACTURING_YEAR'] = this.mANUFACTURINGYEAR;
    data['PLAT_NO'] = this.pLATNO;
    data['KTPNO'] = this.kTPNO;
    data['merk_type'] = this.merkType;
    data['warna'] = this.warna;
    data['estimasi_angsuran'] = this.estimasiAngsuran;
    data['keterlambatan_hari'] = this.keterlambatanHari;
    data['Denda'] = this.denda;
    data['APP_NO'] = this.aPPNO;
    data['OFFICE_CODE'] = this.oFFICECODE;
    data['OFFICE_NAME'] = this.oFFICENAME;
    data['TGL_GOLIVE'] = this.tGLGOLIVE;
    data['USIA_GOLIVE'] = this.uSIAGOLIVE;
    return data;
  }
}

class PilihkontrakError extends PilihkontrakRespon{}