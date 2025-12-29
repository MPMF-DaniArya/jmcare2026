class FormlanjutanRespon {
  List<Data>? data;

  FormlanjutanRespon({this.data});

  FormlanjutanRespon.fromJson(Map<String, dynamic> json) {
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
  String? agreementId;
  String? agreementNo;
  String? alamatPelapor;
  String? alamatPengemudi;
  String? alamatPihakKetiga;
  String? alamatPihakLain;
  String? alamatTertanggung;
  String? appNo;
  String? asuransiPihakKetiga;
  String? asuransiPihakLain;
  String? branchId;
  String? createBy;
  String? createDate;
  String? custFullName;
  String? custIdConfins;
  String? dilaporkanKePolisi;
  String? emailPelapor;
  String? emailTertanggung;
  int? estimasiKerugian;
  String? fileSuratKeputusanFormAwal;
  String? hubunganDenganTertanggung;
  int? id;
  int? idFormawal;
  String? jenisKlaim;
  String? jenisPertanggungan;
  String? jenisSim;
  String? kecepatanSaatKejadian;
  String? kerugianPihakKetiga;
  String? kerugianPihakKetigaDiasuransikan;
  String? kronologiKejadian;
  int? loginUserId;
  String? lokasiKendaraanSaatIni;
  String? masaBerlakuSim;
  String? merkKendataan;
  String? namaPelapor;
  String? namaPengemudi;
  String? namaPihakKetiga;
  String? namaPihakLain;
  String? namaPolsek;
  String? namaTertanggung;
  String? noRegistrasi;
  String? nomorHpPelapor;
  String? nomorHpPihakKetiga;
  String? nomorHpTertanggung;
  String? nomorMesin;
  String? nomorPlat;
  String? nomorPolisAsuransi;
  String? nomorRangka;
  String? nomorSim;
  String? pengemudiBekerjaKpdTertanggung;
  String? pengemudiSepengetahuanTertanggung;
  String? penggunaanKendaraanKejadian;
  String? pihakLainBertanggungjawab;
  String? sisiKendaraanRusak;
  String? statusKlaim;
  String? stplKepolisian;
  String? tahunPembuatan;
  String? tanggalKejadian;
  String? tempatKejadian;
  String? tglLaporFormAwal;
  String? tipeKlaim;

  Data(
      {this.agreementId,
        this.agreementNo,
        this.alamatPelapor,
        this.alamatPengemudi,
        this.alamatPihakKetiga,
        this.alamatPihakLain,
        this.alamatTertanggung,
        this.appNo,
        this.asuransiPihakKetiga,
        this.asuransiPihakLain,
        this.branchId,
        this.createBy,
        this.createDate,
        this.custFullName,
        this.custIdConfins,
        this.dilaporkanKePolisi,
        this.emailPelapor,
        this.emailTertanggung,
        this.estimasiKerugian,
        this.fileSuratKeputusanFormAwal,
        this.hubunganDenganTertanggung,
        this.id,
        this.idFormawal,
        this.jenisKlaim,
        this.jenisPertanggungan,
        this.jenisSim,
        this.kecepatanSaatKejadian,
        this.kerugianPihakKetiga,
        this.kerugianPihakKetigaDiasuransikan,
        this.kronologiKejadian,
        this.loginUserId,
        this.lokasiKendaraanSaatIni,
        this.masaBerlakuSim,
        this.merkKendataan,
        this.namaPelapor,
        this.namaPengemudi,
        this.namaPihakKetiga,
        this.namaPihakLain,
        this.namaPolsek,
        this.namaTertanggung,
        this.noRegistrasi,
        this.nomorHpPelapor,
        this.nomorHpPihakKetiga,
        this.nomorHpTertanggung,
        this.nomorMesin,
        this.nomorPlat,
        this.nomorPolisAsuransi,
        this.nomorRangka,
        this.nomorSim,
        this.pengemudiBekerjaKpdTertanggung,
        this.pengemudiSepengetahuanTertanggung,
        this.penggunaanKendaraanKejadian,
        this.pihakLainBertanggungjawab,
        this.sisiKendaraanRusak,
        this.statusKlaim,
        this.stplKepolisian,
        this.tahunPembuatan,
        this.tanggalKejadian,
        this.tempatKejadian,
        this.tglLaporFormAwal,
        this.tipeKlaim});

  Data.fromJson(Map<String, dynamic> json) {
    agreementId = json['agreement_id'];
    agreementNo = json['agreement_no'];
    alamatPelapor = json['alamat_pelapor'];
    alamatPengemudi = json['alamat_pengemudi'];
    alamatPihakKetiga = json['alamat_pihak_ketiga'];
    alamatPihakLain = json['alamat_pihak_lain'];
    alamatTertanggung = json['alamat_tertanggung'];
    appNo = json['app_no'];
    asuransiPihakKetiga = json['asuransi_pihak_ketiga'];
    asuransiPihakLain = json['asuransi_pihak_lain'];
    branchId = json['branch_id'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    custFullName = json['cust_full_name'];
    custIdConfins = json['cust_id_confins'];
    dilaporkanKePolisi = json['dilaporkan_ke_polisi'];
    emailPelapor = json['email_pelapor'];
    emailTertanggung = json['email_tertanggung'];
    estimasiKerugian = json['estimasi_kerugian'];
    fileSuratKeputusanFormAwal = json['file_surat_keputusan_form_awal'];
    hubunganDenganTertanggung = json['hubungan_dengan_tertanggung'];
    id = json['id'];
    idFormawal = json['id_formawal'];
    jenisKlaim = json['jenis_klaim'];
    jenisPertanggungan = json['jenis_pertanggungan'];
    jenisSim = json['jenis_sim'];
    kecepatanSaatKejadian = json['kecepatan_saat_kejadian'];
    kerugianPihakKetiga = json['kerugian_pihak_ketiga'];
    kerugianPihakKetigaDiasuransikan =
    json['kerugian_pihak_ketiga_diasuransikan'];
    kronologiKejadian = json['kronologi_kejadian'];
    loginUserId = json['login_user_id'];
    lokasiKendaraanSaatIni = json['lokasi_kendaraan_saat_ini'];
    masaBerlakuSim = json['masa_berlaku_sim'];
    merkKendataan = json['merk_kendataan'];
    namaPelapor = json['nama_pelapor'];
    namaPengemudi = json['nama_pengemudi'];
    namaPihakKetiga = json['nama_pihak_ketiga'];
    namaPihakLain = json['nama_pihak_lain'];
    namaPolsek = json['nama_polsek'];
    namaTertanggung = json['nama_tertanggung'];
    noRegistrasi = json['no_registrasi'];
    nomorHpPelapor = json['nomor_hp_pelapor'];
    nomorHpPihakKetiga = json['nomor_hp_pihak_ketiga'];
    nomorHpTertanggung = json['nomor_hp_tertanggung'];
    nomorMesin = json['nomor_mesin'];
    nomorPlat = json['nomor_plat'];
    nomorPolisAsuransi = json['nomor_polis_asuransi'];
    nomorRangka = json['nomor_rangka'];
    nomorSim = json['nomor_sim'];
    pengemudiBekerjaKpdTertanggung = json['pengemudi_bekerja_kpd_tertanggung'];
    pengemudiSepengetahuanTertanggung =
    json['pengemudi_sepengetahuan_tertanggung'];
    penggunaanKendaraanKejadian = json['penggunaan_kendaraan_kejadian'];
    pihakLainBertanggungjawab = json['pihak_lain_bertanggungjawab'];
    sisiKendaraanRusak = json['sisi_kendaraan_rusak'];
    statusKlaim = json['status_klaim'];
    stplKepolisian = json['stpl_kepolisian'];
    tahunPembuatan = json['tahun_pembuatan'];
    tanggalKejadian = json['tanggal_kejadian'];
    tempatKejadian = json['tempat_kejadian'];
    tglLaporFormAwal = json['tgl_lapor_form_awal'];
    tipeKlaim = json['tipe_klaim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agreement_id'] = this.agreementId;
    data['agreement_no'] = this.agreementNo;
    data['alamat_pelapor'] = this.alamatPelapor;
    data['alamat_pengemudi'] = this.alamatPengemudi;
    data['alamat_pihak_ketiga'] = this.alamatPihakKetiga;
    data['alamat_pihak_lain'] = this.alamatPihakLain;
    data['alamat_tertanggung'] = this.alamatTertanggung;
    data['app_no'] = this.appNo;
    data['asuransi_pihak_ketiga'] = this.asuransiPihakKetiga;
    data['asuransi_pihak_lain'] = this.asuransiPihakLain;
    data['branch_id'] = this.branchId;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['cust_full_name'] = this.custFullName;
    data['cust_id_confins'] = this.custIdConfins;
    data['dilaporkan_ke_polisi'] = this.dilaporkanKePolisi;
    data['email_pelapor'] = this.emailPelapor;
    data['email_tertanggung'] = this.emailTertanggung;
    data['estimasi_kerugian'] = this.estimasiKerugian;
    data['file_surat_keputusan_form_awal'] = this.fileSuratKeputusanFormAwal;
    data['hubungan_dengan_tertanggung'] = this.hubunganDenganTertanggung;
    data['id'] = this.id;
    data['id_formawal'] = this.idFormawal;
    data['jenis_klaim'] = this.jenisKlaim;
    data['jenis_pertanggungan'] = this.jenisPertanggungan;
    data['jenis_sim'] = this.jenisSim;
    data['kecepatan_saat_kejadian'] = this.kecepatanSaatKejadian;
    data['kerugian_pihak_ketiga'] = this.kerugianPihakKetiga;
    data['kerugian_pihak_ketiga_diasuransikan'] =
        this.kerugianPihakKetigaDiasuransikan;
    data['kronologi_kejadian'] = this.kronologiKejadian;
    data['login_user_id'] = this.loginUserId;
    data['lokasi_kendaraan_saat_ini'] = this.lokasiKendaraanSaatIni;
    data['masa_berlaku_sim'] = this.masaBerlakuSim;
    data['merk_kendataan'] = this.merkKendataan;
    data['nama_pelapor'] = this.namaPelapor;
    data['nama_pengemudi'] = this.namaPengemudi;
    data['nama_pihak_ketiga'] = this.namaPihakKetiga;
    data['nama_pihak_lain'] = this.namaPihakLain;
    data['nama_polsek'] = this.namaPolsek;
    data['nama_tertanggung'] = this.namaTertanggung;
    data['no_registrasi'] = this.noRegistrasi;
    data['nomor_hp_pelapor'] = this.nomorHpPelapor;
    data['nomor_hp_pihak_ketiga'] = this.nomorHpPihakKetiga;
    data['nomor_hp_tertanggung'] = this.nomorHpTertanggung;
    data['nomor_mesin'] = this.nomorMesin;
    data['nomor_plat'] = this.nomorPlat;
    data['nomor_polis_asuransi'] = this.nomorPolisAsuransi;
    data['nomor_rangka'] = this.nomorRangka;
    data['nomor_sim'] = this.nomorSim;
    data['pengemudi_bekerja_kpd_tertanggung'] =
        this.pengemudiBekerjaKpdTertanggung;
    data['pengemudi_sepengetahuan_tertanggung'] =
        this.pengemudiSepengetahuanTertanggung;
    data['penggunaan_kendaraan_kejadian'] = this.penggunaanKendaraanKejadian;
    data['pihak_lain_bertanggungjawab'] = this.pihakLainBertanggungjawab;
    data['sisi_kendaraan_rusak'] = this.sisiKendaraanRusak;
    data['status_klaim'] = this.statusKlaim;
    data['stpl_kepolisian'] = this.stplKepolisian;
    data['tahun_pembuatan'] = this.tahunPembuatan;
    data['tanggal_kejadian'] = this.tanggalKejadian;
    data['tempat_kejadian'] = this.tempatKejadian;
    data['tgl_lapor_form_awal'] = this.tglLaporFormAwal;
    data['tipe_klaim'] = this.tipeKlaim;
    return data;
  }
}

class FormlanjutanError extends FormlanjutanRespon{}