class SubjekDataPribadiRespon {
  String? namaLengkap;
  String? nomorId;
  String? tempatLahir;
  String? tanggalLahir;

  // String? alamatSesuaiId;
  String? alamatDomisili;
  String? noTelepon;

  // Kontrak? noKontrak;

  SubjekDataPribadiRespon({
    this.namaLengkap,
    this.nomorId,
    this.tempatLahir,
    this.tanggalLahir,
    // this.alamatSesuaiId,
    this.alamatDomisili,
    this.noTelepon,
    // this.noKontrak
  });

  SubjekDataPribadiRespon.fromJson(Map<String, dynamic> json) {
    namaLengkap = json['nama_lengkap'];
    nomorId = json['nomor_id'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tgl_lahir'];
    // alamatSesuaiId = json['alamat_sesuai_id'];
    alamatDomisili = json['alamat_domisili_alamat'];
    noTelepon = json['telepon1'];
    // noKontrak = Kontrak.fromJson(json['list_kontrak'])
  }
}

class SubjekDataPribadiError extends SubjekDataPribadiRespon {}

class Kontrak {
  int? aggrementNo;
  int? aggrementId;

  Kontrak({this.aggrementNo, this.aggrementId});

  Kontrak.fromJson(Map<String, dynamic> json) {
    aggrementNo = json['agrment_no'];
    aggrementId = json['agrmnt_id'];
  }
}
