class DetailFormLanjutanRespon {
  String? alamatPelapor;
  String? alamatPengemudi;
  String? alamatPihakKetiga;
  String? alamatPihakLain;
  String? alamatTertanggung;
  String? asuransiPihakKetiga;
  String? asuransiPihakLain;
  String? base64Stpl;
  String? base64Tandatangan;
  String? catatanAsuransi;
  String? catatanBanding;
  String? createDate;
  String? createDateFormatIndo;
  String? debiturNaikBanding;
  String? debiturSetujuNominal;
  String? dilaporkanKePolisi;
  String? documentChecklist;
  String? documentChecklistDariAsuransi;
  String? documentChecklistDiterimaAsuransi;
  String? emailPelapor;
  String? emailTertanggung;
  int? estimasiKerugian;
  String? fileSurat;
  String? hubunganDenganTertanggung;
  int? id;
  int? idFormawal;
  String? jenisSim;
  String? kecepatanSaatKejadian;
  String? kerugianPihakKetiga;
  String? kerugianPihakKetigaDiasuransikan;
  String? kronologiKejadian;
  int? loginUserId;
  String? lokasiKendaraanSaatIni;
  String? masaBerlakuSim;
  String? masaBerlakuSimFormatIndo;
  String? merkKendataan;
  String? namaFilePdfFormKlaim;
  String? namaFileTandatangan;
  String? namaPelapor;
  String? namaPengemudi;
  String? namaPihakKetiga;
  String? namaPihakLain;
  String? namaPolsek;
  String? namaTertanggung;
  int? nominalDariAsuransiSebelumBanding;
  int? nominalDariAsuransiSesudahBanding;
  int? nominalNaikBanding;
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
  String? statusKeputusanAsuransi;
  String? stplKepolisian;
  String? tahunPembuatan;
  String? tanggalKejadian;
  String? tanggalKejadianFormatIndo;
  String? tempatKejadian;
  String? tglPembayaranDariAsuransi;
  String? tglPembayaranDariAsuransiFormatIndo;

  DetailFormLanjutanRespon(
      {this.alamatPelapor,
        this.alamatPengemudi,
        this.alamatPihakKetiga,
        this.alamatPihakLain,
        this.alamatTertanggung,
        this.asuransiPihakKetiga,
        this.asuransiPihakLain,
        this.base64Stpl,
        this.base64Tandatangan,
        this.catatanAsuransi,
        this.catatanBanding,
        this.createDate,
        this.createDateFormatIndo,
        this.debiturNaikBanding,
        this.debiturSetujuNominal,
        this.dilaporkanKePolisi,
        this.documentChecklist,
        this.documentChecklistDariAsuransi,
        this.documentChecklistDiterimaAsuransi,
        this.emailPelapor,
        this.emailTertanggung,
        this.estimasiKerugian,
        this.fileSurat,
        this.hubunganDenganTertanggung,
        this.id,
        this.idFormawal,
        this.jenisSim,
        this.kecepatanSaatKejadian,
        this.kerugianPihakKetiga,
        this.kerugianPihakKetigaDiasuransikan,
        this.kronologiKejadian,
        this.loginUserId,
        this.lokasiKendaraanSaatIni,
        this.masaBerlakuSim,
        this.masaBerlakuSimFormatIndo,
        this.merkKendataan,
        this.namaFilePdfFormKlaim,
        this.namaFileTandatangan,
        this.namaPelapor,
        this.namaPengemudi,
        this.namaPihakKetiga,
        this.namaPihakLain,
        this.namaPolsek,
        this.namaTertanggung,
        this.nominalDariAsuransiSebelumBanding,
        this.nominalDariAsuransiSesudahBanding,
        this.nominalNaikBanding,
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
        this.statusKeputusanAsuransi,
        this.stplKepolisian,
        this.tahunPembuatan,
        this.tanggalKejadian,
        this.tanggalKejadianFormatIndo,
        this.tempatKejadian,
        this.tglPembayaranDariAsuransi,
        this.tglPembayaranDariAsuransiFormatIndo});

  DetailFormLanjutanRespon.fromJson(Map<String, dynamic> json) {
    alamatPelapor = json['alamat_pelapor'];
    alamatPengemudi = json['alamat_pengemudi'];
    alamatPihakKetiga = json['alamat_pihak_ketiga'];
    alamatPihakLain = json['alamat_pihak_lain'];
    alamatTertanggung = json['alamat_tertanggung'];
    asuransiPihakKetiga = json['asuransi_pihak_ketiga'];
    asuransiPihakLain = json['asuransi_pihak_lain'];
    base64Stpl = json['base64_stpl'];
    base64Tandatangan = json['base64_tandatangan'];
    catatanAsuransi = json['catatan_asuransi'];
    catatanBanding = json['catatan_banding'];
    createDate = json['create_date'];
    createDateFormatIndo = json['create_date_format_indo'];
    debiturNaikBanding = json['debitur_naik_banding'];
    debiturSetujuNominal = json['debitur_setuju_nominal'];
    dilaporkanKePolisi = json['dilaporkan_ke_polisi'];
    documentChecklist = json['document_checklist'];
    documentChecklistDariAsuransi = json['document_checklist_dari_asuransi'];
    documentChecklistDiterimaAsuransi =
    json['document_checklist_diterima_asuransi'];
    emailPelapor = json['email_pelapor'];
    emailTertanggung = json['email_tertanggung'];
    estimasiKerugian = json['estimasi_kerugian'];
    fileSurat = json['file_surat'];
    hubunganDenganTertanggung = json['hubungan_dengan_tertanggung'];
    id = json['id'];
    idFormawal = json['id_formawal'];
    jenisSim = json['jenis_sim'];
    kecepatanSaatKejadian = json['kecepatan_saat_kejadian'];
    kerugianPihakKetiga = json['kerugian_pihak_ketiga'];
    kerugianPihakKetigaDiasuransikan =
    json['kerugian_pihak_ketiga_diasuransikan'];
    kronologiKejadian = json['kronologi_kejadian'];
    loginUserId = json['login_user_id'];
    lokasiKendaraanSaatIni = json['lokasi_kendaraan_saat_ini'];
    masaBerlakuSim = json['masa_berlaku_sim'];
    masaBerlakuSimFormatIndo = json['masa_berlaku_sim_format_indo'];
    merkKendataan = json['merk_kendataan'];
    namaFilePdfFormKlaim = json['nama_file_pdf_form_klaim'];
    namaFileTandatangan = json['nama_file_tandatangan'];
    namaPelapor = json['nama_pelapor'];
    namaPengemudi = json['nama_pengemudi'];
    namaPihakKetiga = json['nama_pihak_ketiga'];
    namaPihakLain = json['nama_pihak_lain'];
    namaPolsek = json['nama_polsek'];
    namaTertanggung = json['nama_tertanggung'];
    nominalDariAsuransiSebelumBanding =
    json['nominal_dari_asuransi_sebelum_banding'];
    nominalDariAsuransiSesudahBanding =
    json['nominal_dari_asuransi_sesudah_banding'];
    nominalNaikBanding = json['nominal_naik_banding'];
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
    statusKeputusanAsuransi = json['status_keputusan_asuransi'];
    stplKepolisian = json['stpl_kepolisian'];
    tahunPembuatan = json['tahun_pembuatan'];
    tanggalKejadian = json['tanggal_kejadian'];
    tanggalKejadianFormatIndo = json['tanggal_kejadian_format_indo'];
    tempatKejadian = json['tempat_kejadian'];
    tglPembayaranDariAsuransi = json['tgl_pembayaran_dari_asuransi'];
    tglPembayaranDariAsuransiFormatIndo =
    json['tgl_pembayaran_dari_asuransi_format_indo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alamat_pelapor'] = this.alamatPelapor;
    data['alamat_pengemudi'] = this.alamatPengemudi;
    data['alamat_pihak_ketiga'] = this.alamatPihakKetiga;
    data['alamat_pihak_lain'] = this.alamatPihakLain;
    data['alamat_tertanggung'] = this.alamatTertanggung;
    data['asuransi_pihak_ketiga'] = this.asuransiPihakKetiga;
    data['asuransi_pihak_lain'] = this.asuransiPihakLain;
    data['base64_stpl'] = this.base64Stpl;
    data['base64_tandatangan'] = this.base64Tandatangan;
    data['catatan_asuransi'] = this.catatanAsuransi;
    data['catatan_banding'] = this.catatanBanding;
    data['create_date'] = this.createDate;
    data['create_date_format_indo'] = this.createDateFormatIndo;
    data['debitur_naik_banding'] = this.debiturNaikBanding;
    data['debitur_setuju_nominal'] = this.debiturSetujuNominal;
    data['dilaporkan_ke_polisi'] = this.dilaporkanKePolisi;
    data['document_checklist'] = this.documentChecklist;
    data['document_checklist_dari_asuransi'] =
        this.documentChecklistDariAsuransi;
    data['document_checklist_diterima_asuransi'] =
        this.documentChecklistDiterimaAsuransi;
    data['email_pelapor'] = this.emailPelapor;
    data['email_tertanggung'] = this.emailTertanggung;
    data['estimasi_kerugian'] = this.estimasiKerugian;
    data['file_surat'] = this.fileSurat;
    data['hubungan_dengan_tertanggung'] = this.hubunganDenganTertanggung;
    data['id'] = this.id;
    data['id_formawal'] = this.idFormawal;
    data['jenis_sim'] = this.jenisSim;
    data['kecepatan_saat_kejadian'] = this.kecepatanSaatKejadian;
    data['kerugian_pihak_ketiga'] = this.kerugianPihakKetiga;
    data['kerugian_pihak_ketiga_diasuransikan'] =
        this.kerugianPihakKetigaDiasuransikan;
    data['kronologi_kejadian'] = this.kronologiKejadian;
    data['login_user_id'] = this.loginUserId;
    data['lokasi_kendaraan_saat_ini'] = this.lokasiKendaraanSaatIni;
    data['masa_berlaku_sim'] = this.masaBerlakuSim;
    data['masa_berlaku_sim_format_indo'] = this.masaBerlakuSimFormatIndo;
    data['merk_kendataan'] = this.merkKendataan;
    data['nama_file_pdf_form_klaim'] = this.namaFilePdfFormKlaim;
    data['nama_file_tandatangan'] = this.namaFileTandatangan;
    data['nama_pelapor'] = this.namaPelapor;
    data['nama_pengemudi'] = this.namaPengemudi;
    data['nama_pihak_ketiga'] = this.namaPihakKetiga;
    data['nama_pihak_lain'] = this.namaPihakLain;
    data['nama_polsek'] = this.namaPolsek;
    data['nama_tertanggung'] = this.namaTertanggung;
    data['nominal_dari_asuransi_sebelum_banding'] =
        this.nominalDariAsuransiSebelumBanding;
    data['nominal_dari_asuransi_sesudah_banding'] =
        this.nominalDariAsuransiSesudahBanding;
    data['nominal_naik_banding'] = this.nominalNaikBanding;
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
    data['status_keputusan_asuransi'] = this.statusKeputusanAsuransi;
    data['stpl_kepolisian'] = this.stplKepolisian;
    data['tahun_pembuatan'] = this.tahunPembuatan;
    data['tanggal_kejadian'] = this.tanggalKejadian;
    data['tanggal_kejadian_format_indo'] = this.tanggalKejadianFormatIndo;
    data['tempat_kejadian'] = this.tempatKejadian;
    data['tgl_pembayaran_dari_asuransi'] = this.tglPembayaranDariAsuransi;
    data['tgl_pembayaran_dari_asuransi_format_indo'] =
        this.tglPembayaranDariAsuransiFormatIndo;
    return data;
  }
}
class DetailFormLanjutanError extends DetailFormLanjutanRespon{}