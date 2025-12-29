class FormawalRespon {
  List<Data>? data;

  FormawalRespon({this.data});

  FormawalRespon.fromJson(Map<String, dynamic> json) {
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
  String? rEASONDESCR;
  String? agreementId;
  String? agreementNo;
  String? appNo;
  String? branchId;
  String? createBy;
  String? createDate;
  String? custFullName;
  String? custIdConfins;
  String? fileSuratKeputusan;
  int? id;
  String? jenisKlaim;
  String? jenisPertanggungan;
  int? loginUserId;
  String? merkKendaraan;
  String? namaTertanggung;
  String? noRegistrasi;
  String? nomorMesin;
  String? nomorPolisAsuransi;
  String? nomorRangka;
  String? nomorPlat;
  String? statusKlaim;
  String? tahunPembuatan;
  String? tglKejadian;
  String? tglLapor;
  String? tipeKlaim;

  Data(
      {this.rEASONDESCR,
        this.agreementId,
        this.agreementNo,
        this.appNo,
        this.branchId,
        this.createBy,
        this.createDate,
        this.custFullName,
        this.custIdConfins,
        this.fileSuratKeputusan,
        this.id,
        this.jenisKlaim,
        this.jenisPertanggungan,
        this.loginUserId,
        this.merkKendaraan,
        this.namaTertanggung,
        this.noRegistrasi,
        this.nomorMesin,
        this.nomorPolisAsuransi,
        this.nomorRangka,
        this.nomorPlat,
        this.statusKlaim,
        this.tahunPembuatan,
        this.tglKejadian,
        this.tglLapor,
        this.tipeKlaim});

  Data.fromJson(Map<String, dynamic> json) {
    rEASONDESCR = json['REASON_DESCR'];
    agreementId = json['agreement_id'];
    agreementNo = json['agreement_no'];
    appNo = json['app_no'];
    branchId = json['branch_id'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    custFullName = json['cust_full_name'];
    custIdConfins = json['cust_id_confins'];
    fileSuratKeputusan = json['file_surat_keputusan'];
    id = json['id'];
    jenisKlaim = json['jenis_klaim'];
    jenisPertanggungan = json['jenis_pertanggungan'];
    loginUserId = json['login_user_id'];
    merkKendaraan = json['merk_kendaraan'];
    namaTertanggung = json['nama_tertanggung'];
    noRegistrasi = json['no_registrasi'];
    nomorMesin = json['nomor_mesin'];
    nomorPolisAsuransi = json['nomor_polis_asuransi'];
    nomorRangka = json['nomor_rangka'];
    nomorPlat = json['nomor_plat'];
    statusKlaim = json['status_klaim'];
    tahunPembuatan = json['tahun_pembuatan'];
    tglKejadian = json['tgl_kejadian'];
    tglLapor = json['tgl_lapor'];
    tipeKlaim = json['tipe_klaim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REASON_DESCR'] = this.rEASONDESCR;
    data['agreement_id'] = this.agreementId;
    data['agreement_no'] = this.agreementNo;
    data['app_no'] = this.appNo;
    data['branch_id'] = this.branchId;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['cust_full_name'] = this.custFullName;
    data['cust_id_confins'] = this.custIdConfins;
    data['file_surat_keputusan'] = this.fileSuratKeputusan;
    data['id'] = this.id;
    data['jenis_klaim'] = this.jenisKlaim;
    data['jenis_pertanggungan'] = this.jenisPertanggungan;
    data['login_user_id'] = this.loginUserId;
    data['merk_kendaraan'] = this.merkKendaraan;
    data['nama_tertanggung'] = this.namaTertanggung;
    data['no_registrasi'] = this.noRegistrasi;
    data['nomor_mesin'] = this.nomorMesin;
    data['nomor_polis_asuransi'] = this.nomorPolisAsuransi;
    data['nomor_rangka'] = this.nomorRangka;
    data['nomor_plat'] = this.nomorPlat;
    data['status_klaim'] = this.statusKlaim;
    data['tahun_pembuatan'] = this.tahunPembuatan;
    data['tgl_kejadian'] = this.tglKejadian;
    data['tgl_lapor'] = this.tglLapor;
    data['tipe_klaim'] = this.tipeKlaim;
    return data;
  }
}

class FormawalError extends FormawalRespon{}