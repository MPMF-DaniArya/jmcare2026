class NotifRespon {
  List<Data>? data;

  NotifRespon({this.data});

  NotifRespon.fromJson(Map<String, dynamic> json) {
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
  String? id;
  int? loginUserId;
  String? onesignalId;
  String? namaNotif;
  String? judulNotif;
  String? isi;
  String? isRead;
  String? createDate;

  Data(
      {this.id,
        this.loginUserId,
        this.onesignalId,
        this.namaNotif,
        this.judulNotif,
        this.isi,
        this.isRead,
        this.createDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginUserId = json['login_user_id'];
    onesignalId = json['onesignal_id'];
    namaNotif = json['nama_notif'];
    judulNotif = json['judul_notif'];
    isi = json['isi'];
    isRead = json['is_read'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_user_id'] = this.loginUserId;
    data['onesignal_id'] = this.onesignalId;
    data['nama_notif'] = this.namaNotif;
    data['judul_notif'] = this.judulNotif;
    data['isi'] = this.isi;
    data['is_read'] = this.isRead;
    data['create_date'] = this.createDate;
    return data;
  }
}
class NotifError extends NotifRespon{}
