class MpmiSubmitDocumentChecklist {
  String? contractNo;
  List<DocumentChecklist>? documentChecklist;
  String? token;

  MpmiSubmitDocumentChecklist(
      {this.contractNo, this.documentChecklist, this.token});

  MpmiSubmitDocumentChecklist.fromJson(Map<String, dynamic> json) {
    contractNo = json['ContractNo'];
    if (json['DocumentChecklist'] != null) {
      documentChecklist = <DocumentChecklist>[];
      json['DocumentChecklist'].forEach((v) {
        documentChecklist!.add(new DocumentChecklist.fromJson(v));
      });
    }
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContractNo'] = this.contractNo;
    if (this.documentChecklist != null) {
      data['DocumentChecklist'] =
          this.documentChecklist!.map((v) => v.toJson()).toList();
    }
    data['Token'] = this.token;
    return data;
  }
}

class DocumentChecklist {
  String? documentCode;
  bool? checked;

  DocumentChecklist({this.documentCode, this.checked});

  DocumentChecklist.fromJson(Map<String, dynamic> json) {
    documentCode = json['DocumentCode'];
    checked = json['Checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentCode'] = this.documentCode;
    data['Checked'] = this.checked;
    return data;
  }
}
