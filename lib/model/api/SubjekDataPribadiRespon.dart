class SubjekDataPribadiRespon {
  String? namaLengkap;
  String? nomorId;
  String? tempatLahir;
  String? tanggalLahir;
  String? alamatDomisili;
  String? noTelepon;
  String? noKontrak;
  String? alamatLegalAlamat;
  String? alamatLegalKecamatan;
  String? alamatLegalKelurahan;
  String? alamatLegalKodepos;
  String? alamatLegalKota;
  String? alamatLegalRt;
  String? alamatLegalRw;

  SubjekDataPribadiRespon({
    this.namaLengkap,
    this.nomorId,
    this.tempatLahir,
    this.tanggalLahir,
    this.alamatDomisili,
    this.noTelepon,
    this.noKontrak,
    this.alamatLegalAlamat,
    this.alamatLegalKecamatan,
    this.alamatLegalKelurahan,
    this.alamatLegalKodepos,
    this.alamatLegalKota,
    this.alamatLegalRt,
    this.alamatLegalRw,
  });

  SubjekDataPribadiRespon.fromJson(Map<String, dynamic> json) {
    final noKontrakResponse = json['list_kontrak'];

    namaLengkap = json['nama_lengkap'];
    nomorId = json['nomor_id'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tgl_lahir'];
    alamatDomisili = json['alamat_domisili_alamat'];
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

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_lengkap'] = namaLengkap;
    data['nomor_id'] = nomorId;
    data['tempat_lahir'] = tempatLahir;
    data['tgl_lahir'] = tanggalLahir;
    data['alamat_domisili_alamat'] = alamatDomisili;
    data['telepon1'] = noTelepon;

    data['no_kontrak'] = noKontrak;

    data['alamat_legal_alamat'] = alamatLegalAlamat;
    data['alamat_legal_kecamatan'] = alamatLegalKecamatan;
    data['alamat_legal_kelurahan'] = alamatLegalKelurahan;
    data['alamat_legal_kodepos'] = alamatLegalKodepos;
    data['alamat_legal_kota'] = alamatLegalKota;
    data['alamat_legal_rt'] = alamatLegalRt;
    data['alamat_legal_rw'] = alamatLegalRw;

    return data;
  }
}

class SubjekDataPribadiError extends SubjekDataPribadiRespon {}
