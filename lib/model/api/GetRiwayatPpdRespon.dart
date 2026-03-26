class GetRiwayatPpdRespon {
  String? createDate;
  String? noTiket;
  String? status;


  GetRiwayatPpdRespon({
    this.createDate,
    this.noTiket,
    this.status,
  });

  GetRiwayatPpdRespon.fromJson(Map<String, dynamic> json) {
    createDate = json['create_date'];
    noTiket = json['no_tiket'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create_date'] = createDate;
    data['no_tiket'] = noTiket;
    data['status'] = status;

    return data;
  }
}

class GetRiwayatPdpError extends GetRiwayatPpdRespon {}
