class DropdownRespon {
  List<Data>? data;

  DropdownRespon({this.data});

  DropdownRespon.fromJson(Map<String, dynamic> json) {
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
  bool? enabled;
  bool? selected;
  String? createBy;
  String? createDate;
  int? id;
  String? idDropdown;
  String? modul;
  String? submodul;
  String? subtitleDropdown;
  String? titleDropdown;

  Data(
      {this.enabled,
        this.selected,
        this.createBy,
        this.createDate,
        this.id,
        this.idDropdown,
        this.modul,
        this.submodul,
        this.subtitleDropdown,
        this.titleDropdown});

  Data.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    selected = json['selected'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    id = json['id'];
    idDropdown = json['id_dropdown'];
    modul = json['modul'];
    submodul = json['submodul'];
    subtitleDropdown = json['subtitle_dropdown'];
    titleDropdown = json['title_dropdown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['selected'] = this.selected;
    data['create_by'] = this.createBy;
    data['create_date'] = this.createDate;
    data['id'] = this.id;
    data['id_dropdown'] = this.idDropdown;
    data['modul'] = this.modul;
    data['submodul'] = this.submodul;
    data['subtitle_dropdown'] = this.subtitleDropdown;
    data['title_dropdown'] = this.titleDropdown;
    return data;
  }
}


class DropdownError extends DropdownRespon{}