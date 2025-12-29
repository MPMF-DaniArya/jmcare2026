class EsignInvitationRequest {
  String? provinsi;
  String? kota;
  String? kelurahan;
  String? tmpLahir;
  String? alamat;
  String? tglLahir;
  String? nama;
  String? kecamatan;
  String? tlp;
  String? jenisKelamin;
  String? idKtp;
  String? kodePos;
  String? email;

  EsignInvitationRequest(
      {this.provinsi, this.kota, this.kelurahan, this.tmpLahir, this.alamat, this.tglLahir, this.nama, this.kecamatan, this.tlp, this.jenisKelamin, this.idKtp, this.kodePos, this.email});

  EsignInvitationRequest.fromJson(Map<String, dynamic> json) {
    provinsi = json['provinsi'];
    kota = json['kota'];
    kelurahan = json['kelurahan'];
    tmpLahir = json['tmpLahir'];
    alamat = json['alamat'];
    tglLahir = json['tglLahir'];
    nama = json['nama'];
    kecamatan = json['kecamatan'];
    tlp = json['tlp'];
    jenisKelamin = json['jenisKelamin'];
    idKtp = json['idKtp'];
    kodePos = json['kodePos'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinsi'] = this.provinsi;
    data['kota'] = this.kota;
    data['kelurahan'] = this.kelurahan;
    data['tmpLahir'] = this.tmpLahir;
    data['alamat'] = this.alamat;
    data['tglLahir'] = this.tglLahir;
    data['nama'] = this.nama;
    data['kecamatan'] = this.kecamatan;
    data['tlp'] = this.tlp;
    data['jenisKelamin'] = this.jenisKelamin;
    data['idKtp'] = this.idKtp;
    data['kodePos'] = this.kodePos;
    data['email'] = this.email;
    return data;
  }
}
