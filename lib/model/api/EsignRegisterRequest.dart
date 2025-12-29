class EsignRegisterRequest {
  Audit? audit;
  String? psreCode;
  String? nama;
  String? email;
  String? tmpLahir;
  String? tglLahir;
  String? jenisKelamin;
  String? tlp;
  String? idKtp;
  String? alamat;
  String? kecamatan;
  String? kelurahan;
  String? kota;
  String? provinsi;
  String? kodePos;
  String? selfPhoto;
  String? idPhoto;
  String? password;

  EsignRegisterRequest(
      {this.audit,
      this.psreCode,
      this.nama,
      this.email,
      this.tmpLahir,
      this.tglLahir,
      this.jenisKelamin,
      this.tlp,
      this.idKtp,
      this.alamat,
      this.kecamatan,
      this.kelurahan,
      this.kota,
      this.provinsi,
      this.kodePos,
      this.selfPhoto,
      this.idPhoto,
      this.password});

  EsignRegisterRequest.fromJson(Map<String, dynamic> json) {
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    psreCode = json['psreCode'];
    nama = json['nama'];
    email = json['email'];
    tmpLahir = json['tmpLahir'];
    tglLahir = json['tglLahir'];
    jenisKelamin = json['jenisKelamin'];
    tlp = json['tlp'];
    idKtp = json['idKtp'];
    alamat = json['alamat'];
    kecamatan = json['kecamatan'];
    kelurahan = json['kelurahan'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    kodePos = json['kodePos'];
    selfPhoto = json['selfPhoto'];
    idPhoto = json['idPhoto'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    data['psreCode'] = this.psreCode;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['tmpLahir'] = this.tmpLahir;
    data['tglLahir'] = this.tglLahir;
    data['jenisKelamin'] = this.jenisKelamin;
    data['tlp'] = this.tlp;
    data['idKtp'] = this.idKtp;
    data['alamat'] = this.alamat;
    data['kecamatan'] = this.kecamatan;
    data['kelurahan'] = this.kelurahan;
    data['kota'] = this.kota;
    data['provinsi'] = this.provinsi;
    data['kodePos'] = this.kodePos;
    data['selfPhoto'] = this.selfPhoto;
    data['idPhoto'] = this.idPhoto;
    data['password'] = this.password;
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
