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
    var noKontrakResponse = json['list_kontrak'];

    namaLengkap = json['nama_lengkap'];
    nomorId = json['nomor_id'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tgl_lahir'];
    alamatDomisili = json['alamat_domisili_alamat'];
    noTelepon = json['telepon1'];
    if (noKontrakResponse.isNotEmpty) {
      noKontrak = noKontrakResponse.first['agrment_no'].toString();
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
}

class SubjekDataPribadiError extends SubjekDataPribadiRespon {}
