class GetRiwayatPpdRespon {
  String? createDate;
  String? noTiket;
  String? status;
  String? tipePerubahanData;

  GetRiwayatPpdRespon({
    this.createDate,
    this.noTiket,
    this.status,
    this.tipePerubahanData,
  });

  GetRiwayatPpdRespon.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'];
    noTiket = json['no_tiket'];
    status = json['status'];
    tipePerubahanData = json['tipe_perubahan_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create_date'] = createDate;
    data['no_tiket'] = noTiket;
    data['status'] = status;
    data['tipe_perubahan_data'] = tipePerubahanData;

    return data;
  }
}

class GetRiwayatPdpError extends GetRiwayatPpdRespon {}
