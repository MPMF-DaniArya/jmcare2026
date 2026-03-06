class GetRiwayatPpdRespon {
  String? base64File;
  String? createDate;
  String? dataSaatIni;
  String? jenisPerubahanData;
  String? keterangan;
  String? noTiket;
  String? perubahanData;
  String? status;

  GetRiwayatPpdRespon({
    this.base64File,
    this.createDate,
    this.dataSaatIni,
    this.jenisPerubahanData,
    this.keterangan,
    this.noTiket,
    this.perubahanData,
    this.status,
  });

  GetRiwayatPpdRespon.fromJson(Map<String, dynamic> json) {
    base64File = json['base64file'];
    createDate = json['create_date'];
    dataSaatIni = json['data_saat_ini'];
    jenisPerubahanData = json['jenis_perubahan_data'];
    keterangan = json['keterangan'];
    noTiket = json['no_tiket'];
    perubahanData = json['perubahan_data'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base64file'] = base64File;
    data['create_date'] = createDate;
    data['data_saat_ini'] = dataSaatIni;
    data['jenis_perubahan_data'] = jenisPerubahanData;
    data['keterangan'] = keterangan;
    data['no_tiket'] = noTiket;
    data['perubahan_data'] = perubahanData;
    data['status'] = status;

    return data;
  }
}

class GetRiwayatPdpError extends GetRiwayatPpdRespon {}
