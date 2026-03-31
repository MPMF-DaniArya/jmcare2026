class SubjekDataPribadiRespon {
  String? namaLengkap;
  String? nomorId;
  String? tempatLahir;
  String? tanggalLahir;
  String? alamatDomisili;

  // alamat domisili
  String? alamatDomisiliKecamatan;
  String? alamatDomisiliKelurahan;
  String? alamatDomisiliKodepos;
  String? alamatDomisiliKota;
  String? alamatDomisiliRt;
  String? alamatDomisiliRw;

  // =======================
  String? noTelepon;
  String? noKontrak;

  // alamat sesuai ID
  String? alamatLegalAlamat;
  String? alamatLegalKecamatan;
  String? alamatLegalKelurahan;
  String? alamatLegalKodepos;
  String? alamatLegalKota;
  String? alamatLegalRt;
  String? alamatLegalRw;

  // =====================
  String? email;

  SubjekDataPribadiRespon(
      {this.namaLengkap,
      this.nomorId,
      this.tempatLahir,
      this.tanggalLahir,
      this.alamatDomisili,
      this.alamatDomisiliKecamatan,
      this.alamatDomisiliKelurahan,
      this.alamatDomisiliKodepos,
      this.alamatDomisiliKota,
      this.alamatDomisiliRt,
      this.alamatDomisiliRw,
      this.noTelepon,
      this.noKontrak,
      this.alamatLegalAlamat,
      this.alamatLegalKecamatan,
      this.alamatLegalKelurahan,
      this.alamatLegalKodepos,
      this.alamatLegalKota,
      this.alamatLegalRt,
      this.alamatLegalRw,
      this.email});

  SubjekDataPribadiRespon.fromJson(Map<String, dynamic> json) {
    final noKontrakResponse = json['list_kontrak'];

    namaLengkap = json['nama_lengkap'];
    nomorId = json['nomor_id'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tgl_lahir'];
    alamatDomisili = json['alamat_domisili_alamat'];
    alamatDomisiliKecamatan = json['alamat_domisili_kecamatan'];
    alamatDomisiliKelurahan = json['alamat_domisili_kelurahan'];
    alamatDomisiliKodepos = json['alamat_domisili_kodepos'];
    alamatDomisiliKota = json['alamat_domisili_kota'];
    alamatDomisiliRt = json['alamat_domisili_rt'];
    alamatDomisiliRw = json['alamat_domisili_rw'];
    noTelepon = json['telepon1'];
    if (noKontrakResponse is List && noKontrakResponse.isNotEmpty) {
      noKontrak = noKontrakResponse.first['agrment_no'].toString();
    } else if (json['no_kontrak'] != null) {
      noKontrak = json['no_kontrak']?.toString();
    } else {
      noKontrak = "-";
    }
    alamatLegalAlamat = json['alamat_legal_alamat'];
    alamatLegalKecamatan = json['alamat_legal_kecamatan'];
    alamatLegalKelurahan = json['alamat_legal_kelurahan'];
    alamatLegalKodepos = json['alamat_legal_kodepos'];
    alamatLegalKota = json['alamat_legal_kota'];
    alamatLegalRt = json['alamat_legal_rt'];
    alamatLegalRw = json['alamat_legal_rw'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_lengkap'] = namaLengkap;
    data['nomor_id'] = nomorId;
    data['tempat_lahir'] = tempatLahir;
    data['tgl_lahir'] = tanggalLahir;
    data['alamat_domisili_alamat'] = alamatDomisili;
    data['alamat_domisili_kecamatan'] = alamatDomisiliKecamatan;
    data['alamat_domisili_kelurahan'] = alamatDomisiliKelurahan;
    data['alamat_domisili_kodepos'] = alamatDomisiliKodepos;
    data['alamat_domisili_kota'] = alamatDomisiliKota;
    data['alamat_domisili_rt'] = alamatDomisiliRt;
    data['alamat_domisili_rw'] = alamatDomisiliRw;
    data['telepon1'] = noTelepon;

    data['no_kontrak'] = noKontrak;

    data['alamat_legal_alamat'] = alamatLegalAlamat;
    data['alamat_legal_kecamatan'] = alamatLegalKecamatan;
    data['alamat_legal_kelurahan'] = alamatLegalKelurahan;
    data['alamat_legal_kodepos'] = alamatLegalKodepos;
    data['alamat_legal_kota'] = alamatLegalKota;
    data['alamat_legal_rt'] = alamatLegalRt;
    data['alamat_legal_rw'] = alamatLegalRw;
    data['email'] = email;

    return data;
  }
}

class SubjekDataPribadiError extends SubjekDataPribadiRespon {}
