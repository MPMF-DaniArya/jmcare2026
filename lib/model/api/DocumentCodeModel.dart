class DocumentCodeModel {
  String? documentCode;

  DocumentCodeModel({this.documentCode});

  DocumentCodeModel.fromJson(Map<String, dynamic> json) {
    documentCode = json['DocumentCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentCode'] = this.documentCode;
    return data;
  }
}
