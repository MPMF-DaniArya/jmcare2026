class DetailFormLanjutanRequest {
  int? idFormawal;

  DetailFormLanjutanRequest({this.idFormawal});

  DetailFormLanjutanRequest.fromJson(Map<String, dynamic> json) {
    idFormawal = json['id_formawal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_formawal'] = this.idFormawal;
    return data;
  }
}
