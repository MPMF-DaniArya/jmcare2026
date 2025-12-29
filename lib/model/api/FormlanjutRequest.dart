class FormlanjutRequest {
  int? idFormawal;
  int? loginUserId;
  String? nomorPolisAsuransi;
  String? namaTertanggung;
  String? alamatTertanggung;
  String? nomorHpTertanggung;
  String? emailTertanggung;
  String? namaPelapor;
  String? alamatPelapor;
  String? nomorHpPelapor;
  String? emailPelapor;
  String? hubunganDenganTertanggung;
  String? merkKendataan;
  String? tahunPembuatan;
  String? nomorRangka;
  String? nomorMesin;
  String? nomorPlat;
  String? tanggalKejadian;
  String? tempatKejadian;
  String? kecepatanSaatKejadian;
  String? namaPengemudi;
  String? alamatPengemudi;
  String? jenisSim;
  String? nomorSim;
  String? masaBerlakuSim;
  String? pengemudiBekerjaKpdTertanggung;
  String? pengemudiSepengetahuanTertanggung;
  String? penggunaanKendaraanKejadian;
  String? dilaporkanKePolisi;
  String? namaPolsek;
  String? lokasiKendaraanSaatIni;
  String? sisiKendaraanRusak;
  int? estimasiKerugian;
  String? pihakLainBertanggungjawab;
  String? namaPihakLain;
  String? alamatPihakLain;
  String? asuransiPihakLain;
  String? namaPihakKetiga;
  String? alamatPihakKetiga;
  String? nomorHpPihakKetiga;
  String? kerugianPihakKetiga;
  String? kerugianPihakKetigaDiasuransikan;
  String? asuransiPihakKetiga;
  String? kronologiKejadian;
  String? tandatangan;
  String? stplKepolisian;

  FormlanjutRequest(
      {this.idFormawal,
        this.loginUserId,
        this.nomorPolisAsuransi,
        this.namaTertanggung,
        this.alamatTertanggung,
        this.nomorHpTertanggung,
        this.emailTertanggung,
        this.namaPelapor,
        this.alamatPelapor,
        this.nomorHpPelapor,
        this.emailPelapor,
        this.hubunganDenganTertanggung,
        this.merkKendataan,
        this.tahunPembuatan,
        this.nomorRangka,
        this.nomorMesin,
        this.nomorPlat,
        this.tanggalKejadian,
        this.tempatKejadian,
        this.kecepatanSaatKejadian,
        this.namaPengemudi,
        this.alamatPengemudi,
        this.jenisSim,
        this.nomorSim,
        this.masaBerlakuSim,
        this.pengemudiBekerjaKpdTertanggung,
        this.pengemudiSepengetahuanTertanggung,
        this.penggunaanKendaraanKejadian,
        this.dilaporkanKePolisi,
        this.namaPolsek,
        this.lokasiKendaraanSaatIni,
        this.sisiKendaraanRusak,
        this.estimasiKerugian,
        this.pihakLainBertanggungjawab,
        this.namaPihakLain,
        this.alamatPihakLain,
        this.asuransiPihakLain,
        this.namaPihakKetiga,
        this.alamatPihakKetiga,
        this.nomorHpPihakKetiga,
        this.kerugianPihakKetiga,
        this.kerugianPihakKetigaDiasuransikan,
        this.asuransiPihakKetiga,
        this.kronologiKejadian,
        this.tandatangan,
        this.stplKepolisian});

  FormlanjutRequest.fromJson(Map<String, dynamic> json) {
    idFormawal = json['id_formawal'];
    loginUserId = json['login_user_id'];
    nomorPolisAsuransi = json['nomor_polis_asuransi'];
    namaTertanggung = json['nama_tertanggung'];
    alamatTertanggung = json['alamat_tertanggung'];
    nomorHpTertanggung = json['nomor_hp_tertanggung'];
    emailTertanggung = json['email_tertanggung'];
    namaPelapor = json['nama_pelapor'];
    alamatPelapor = json['alamat_pelapor'];
    nomorHpPelapor = json['nomor_hp_pelapor'];
    emailPelapor = json['email_pelapor'];
    hubunganDenganTertanggung = json['hubungan_dengan_tertanggung'];
    merkKendataan = json['merk_kendataan'];
    tahunPembuatan = json['tahun_pembuatan'];
    nomorRangka = json['nomor_rangka'];
    nomorMesin = json['nomor_mesin'];
    nomorPlat = json['nomor_plat'];
    tanggalKejadian = json['tanggal_kejadian'];
    tempatKejadian = json['tempat_kejadian'];
    kecepatanSaatKejadian = json['kecepatan_saat_kejadian'];
    namaPengemudi = json['nama_pengemudi'];
    alamatPengemudi = json['alamat_pengemudi'];
    jenisSim = json['jenis_sim'];
    nomorSim = json['nomor_sim'];
    masaBerlakuSim = json['masa_berlaku_sim'];
    pengemudiBekerjaKpdTertanggung = json['pengemudi_bekerja_kpd_tertanggung'];
    pengemudiSepengetahuanTertanggung =
    json['pengemudi_sepengetahuan_tertanggung'];
    penggunaanKendaraanKejadian = json['penggunaan_kendaraan_kejadian'];
    dilaporkanKePolisi = json['dilaporkan_ke_polisi'];
    namaPolsek = json['nama_polsek'];
    lokasiKendaraanSaatIni = json['lokasi_kendaraan_saat_ini'];
    sisiKendaraanRusak = json['sisi_kendaraan_rusak'];
    estimasiKerugian = json['estimasi_kerugian'];
    pihakLainBertanggungjawab = json['pihak_lain_bertanggungjawab'];
    namaPihakLain = json['nama_pihak_lain'];
    alamatPihakLain = json['alamat_pihak_lain'];
    asuransiPihakLain = json['asuransi_pihak_lain'];
    namaPihakKetiga = json['nama_pihak_ketiga'];
    alamatPihakKetiga = json['alamat_pihak_ketiga'];
    nomorHpPihakKetiga = json['nomor_hp_pihak_ketiga'];
    kerugianPihakKetiga = json['kerugian_pihak_ketiga'];
    kerugianPihakKetigaDiasuransikan =
    json['kerugian_pihak_ketiga_diasuransikan'];
    asuransiPihakKetiga = json['asuransi_pihak_ketiga'];
    kronologiKejadian = json['kronologi_kejadian'];
    tandatangan = json['tandatangan'];
    stplKepolisian = json['stpl_kepolisian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_formawal'] = this.idFormawal;
    data['login_user_id'] = this.loginUserId;
    data['nomor_polis_asuransi'] = this.nomorPolisAsuransi;
    data['nama_tertanggung'] = this.namaTertanggung;
    data['alamat_tertanggung'] = this.alamatTertanggung;
    data['nomor_hp_tertanggung'] = this.nomorHpTertanggung;
    data['email_tertanggung'] = this.emailTertanggung;
    data['nama_pelapor'] = this.namaPelapor;
    data['alamat_pelapor'] = this.alamatPelapor;
    data['nomor_hp_pelapor'] = this.nomorHpPelapor;
    data['email_pelapor'] = this.emailPelapor;
    data['hubungan_dengan_tertanggung'] = this.hubunganDenganTertanggung;
    data['merk_kendataan'] = this.merkKendataan;
    data['tahun_pembuatan'] = this.tahunPembuatan;
    data['nomor_rangka'] = this.nomorRangka;
    data['nomor_mesin'] = this.nomorMesin;
    data['nomor_plat'] = this.nomorPlat;
    data['tanggal_kejadian'] = this.tanggalKejadian;
    data['tempat_kejadian'] = this.tempatKejadian;
    data['kecepatan_saat_kejadian'] = this.kecepatanSaatKejadian;
    data['nama_pengemudi'] = this.namaPengemudi;
    data['alamat_pengemudi'] = this.alamatPengemudi;
    data['jenis_sim'] = this.jenisSim;
    data['nomor_sim'] = this.nomorSim;
    data['masa_berlaku_sim'] = this.masaBerlakuSim;
    data['pengemudi_bekerja_kpd_tertanggung'] =
        this.pengemudiBekerjaKpdTertanggung;
    data['pengemudi_sepengetahuan_tertanggung'] =
        this.pengemudiSepengetahuanTertanggung;
    data['penggunaan_kendaraan_kejadian'] = this.penggunaanKendaraanKejadian;
    data['dilaporkan_ke_polisi'] = this.dilaporkanKePolisi;
    data['nama_polsek'] = this.namaPolsek;
    data['lokasi_kendaraan_saat_ini'] = this.lokasiKendaraanSaatIni;
    data['sisi_kendaraan_rusak'] = this.sisiKendaraanRusak;
    data['estimasi_kerugian'] = this.estimasiKerugian;
    data['pihak_lain_bertanggungjawab'] = this.pihakLainBertanggungjawab;
    data['nama_pihak_lain'] = this.namaPihakLain;
    data['alamat_pihak_lain'] = this.alamatPihakLain;
    data['asuransi_pihak_lain'] = this.asuransiPihakLain;
    data['nama_pihak_ketiga'] = this.namaPihakKetiga;
    data['alamat_pihak_ketiga'] = this.alamatPihakKetiga;
    data['nomor_hp_pihak_ketiga'] = this.nomorHpPihakKetiga;
    data['kerugian_pihak_ketiga'] = this.kerugianPihakKetiga;
    data['kerugian_pihak_ketiga_diasuransikan'] =
        this.kerugianPihakKetigaDiasuransikan;
    data['asuransi_pihak_ketiga'] = this.asuransiPihakKetiga;
    data['kronologi_kejadian'] = this.kronologiKejadian;
    data['tandatangan'] = this.tandatangan;
    data['stpl_kepolisian'] = this.stplKepolisian;
    return data;
  }
}
