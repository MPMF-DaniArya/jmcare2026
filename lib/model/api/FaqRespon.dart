class FaqRespon {
  List<Data>? data;

  FaqRespon({this.data});

  FaqRespon.fromJson(Map<String, dynamic> json) {
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
  String? active;
  String? createBy;
  String? createDate;
  int? id;
  String? jawaban;
  String? pertanyaan;

  Data(
      {this.active,
        this.createBy,
        this.createDate,
        this.id,
        this.jawaban,
        this.pertanyaan});

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    id = json['id'];
    jawaban = json['jawaban'];
    pertanyaan = json['pertanyaan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['id'] = this.id;
    data['jawaban'] = this.jawaban;
    data['pertanyaan'] = this.pertanyaan;
    return data;
  }
}
class FaqError extends FaqRespon{}