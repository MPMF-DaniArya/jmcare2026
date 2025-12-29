class KodeposRespon {
  List<Data>? data;

  KodeposRespon({this.data});

  KodeposRespon.fromJson(Map<String, dynamic> json) {
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
  String? kelurahan;
  String? zipCode;
  String? city;
  String? kecamatan;

  Data({this.kelurahan, this.zipCode, this.city, this.kecamatan});

  Data.fromJson(Map<String, dynamic> json) {
    kelurahan = json['Kelurahan'];
    zipCode = json['ZipCode'];
    city = json['city'];
    kecamatan = json['kecamatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Kelurahan'] = this.kelurahan;
    data['ZipCode'] = this.zipCode;
    data['city'] = this.city;
    data['kecamatan'] = this.kecamatan;
    return data;
  }
}

class KodeposError extends KodeposRespon {}