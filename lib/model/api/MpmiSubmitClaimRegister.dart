class MpmiSubmitClaimRegister {
  String? reportDate;
  String? contractNo;
  String? insuredName;
  String? policyNo;
  String? coverage;
  String? dateOfIncident;
  String? claimType;
  String? branchName;
  String? token;

  MpmiSubmitClaimRegister(
      {this.reportDate,
        this.contractNo,
        this.insuredName,
        this.policyNo,
        this.coverage,
        this.dateOfIncident,
        this.claimType,
        this.branchName,
        this.token});

  MpmiSubmitClaimRegister.fromJson(Map<String, dynamic> json) {
    reportDate = json['ReportDate'];
    contractNo = json['ContractNo'];
    insuredName = json['InsuredName'];
    policyNo = json['PolicyNo'];
    coverage = json['Coverage'];
    dateOfIncident = json['DateOfIncident'];
    claimType = json['ClaimType'];
    branchName = json['BranchName'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReportDate'] = this.reportDate;
    data['ContractNo'] = this.contractNo;
    data['InsuredName'] = this.insuredName;
    data['PolicyNo'] = this.policyNo;
    data['Coverage'] = this.coverage;
    data['DateOfIncident'] = this.dateOfIncident;
    data['ClaimType'] = this.claimType;
    data['BranchName'] = this.branchName;
    data['Token'] = this.token;
    return data;
  }
}
