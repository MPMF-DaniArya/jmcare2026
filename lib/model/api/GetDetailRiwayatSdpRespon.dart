class GetDetailRiwayatSpdRespon {
  HeaderData? header;
  List<DetailData>? detail;

  GetDetailRiwayatSpdRespon({this.header, this.detail});

  GetDetailRiwayatSpdRespon.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? HeaderData.fromJson(json['header']) : null;
    if (json['detail'] != null) {
      detail = <DetailData>[];
      json['detail'].forEach((v) {
        detail!.add(DetailData.fromJson(v));
      });
    }
  }
}

class HeaderData {
  String? idPengajuan;
  String? keterangan;
  String? statusPengajuan;
  String? tanggalPengajuan;
  String? tipePengajuan;

  HeaderData({
    this.idPengajuan,
    this.keterangan,
    this.statusPengajuan,
    this.tanggalPengajuan,
    this.tipePengajuan,
  });

  HeaderData.fromJson(Map<String, dynamic> json) {
    idPengajuan = json['id_pengajuan'];
    keterangan = json['keterangan'];
    statusPengajuan = json['status_pengajuan'];
    tanggalPengajuan = json['tanggal_pengajuan'];
    tipePengajuan = json['tipe_pengajuan'];
  }
}

class DetailData {
  String? base64FileKk;
  String? base64FileKtp;
  String? base64FilePendukung;
  String? createBy;
  String? createDate;
  String? dataSaatIni;
  String? filePendukung;
  int? id;
  String? jenisPerubahanData;
  String? keterangan;
  int? loginUserId;
  String? noTiket;
  String? perubahanData;
  String? status;
  String? tipePerubahanData;

  DetailData({
    this.base64FileKk,
    this.base64FileKtp,
    this.base64FilePendukung,
    this.createBy,
    this.createDate,
    this.dataSaatIni,
    this.filePendukung,
    this.id,
    this.jenisPerubahanData,
    this.keterangan,
    this.loginUserId,
    this.noTiket,
    this.perubahanData,
    this.status,
    this.tipePerubahanData,
  });

  DetailData.fromJson(Map<String, dynamic> json) {
    base64FileKk = json['base64_filekk'];
    base64FileKtp = json['base64_filektp'];
    base64FilePendukung = json['base64_filependukung'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    dataSaatIni = json['data_saat_ini'];
    filePendukung = json['file_pendukung'];
    id = json['id'];
    jenisPerubahanData = json['jenis_perubahan_data'];
    keterangan = json['keterangan'];
    loginUserId = json['login_user_id'];
    noTiket = json['no_tiket'];
    perubahanData = json['perubahan_data'];
    status = json['status'];
    tipePerubahanData = json['tipe_perubahan_data'];
  }
}

class GetDetailRiwayatSdpError extends GetDetailRiwayatSpdRespon {}
