class MpmiSubmitClaimDetail {
  List<InsuredDetail>? insuredDetail;
  List<ClaimantDetail>? claimantDetail;
  List<VehicleDetail>? vehicleDetail;
  List<IncidentDetail>? incidentDetail;
  List<DetailOfLoss>? detailOfLoss;
  List<ThirdPartyDetail>? thirdPartyDetail;
  List<DocumentDetail>? documentDetail;
  String? token;

  MpmiSubmitClaimDetail(
      {this.insuredDetail,
        this.claimantDetail,
        this.vehicleDetail,
        this.incidentDetail,
        this.detailOfLoss,
        this.thirdPartyDetail,
        this.documentDetail,
        this.token});

  MpmiSubmitClaimDetail.fromJson(Map<String, dynamic> json) {
    if (json['InsuredDetail'] != null) {
      insuredDetail = <InsuredDetail>[];
      json['InsuredDetail'].forEach((v) {
        insuredDetail!.add(new InsuredDetail.fromJson(v));
      });
    }
    if (json['ClaimantDetail'] != null) {
      claimantDetail = <ClaimantDetail>[];
      json['ClaimantDetail'].forEach((v) {
        claimantDetail!.add(new ClaimantDetail.fromJson(v));
      });
    }
    if (json['VehicleDetail'] != null) {
      vehicleDetail = <VehicleDetail>[];
      json['VehicleDetail'].forEach((v) {
        vehicleDetail!.add(new VehicleDetail.fromJson(v));
      });
    }
    if (json['IncidentDetail'] != null) {
      incidentDetail = <IncidentDetail>[];
      json['IncidentDetail'].forEach((v) {
        incidentDetail!.add(new IncidentDetail.fromJson(v));
      });
    }
    if (json['DetailOfLoss'] != null) {
      detailOfLoss = <DetailOfLoss>[];
      json['DetailOfLoss'].forEach((v) {
        detailOfLoss!.add(new DetailOfLoss.fromJson(v));
      });
    }
    if (json['ThirdPartyDetail'] != null) {
      thirdPartyDetail = <ThirdPartyDetail>[];
      json['ThirdPartyDetail'].forEach((v) {
        thirdPartyDetail!.add(new ThirdPartyDetail.fromJson(v));
      });
    }
    if (json['DocumentDetail'] != null) {
      documentDetail = <DocumentDetail>[];
      json['DocumentDetail'].forEach((v) {
        documentDetail!.add(new DocumentDetail.fromJson(v));
      });
    }
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insuredDetail != null) {
      data['InsuredDetail'] =
          this.insuredDetail!.map((v) => v.toJson()).toList();
    }
    if (this.claimantDetail != null) {
      data['ClaimantDetail'] =
          this.claimantDetail!.map((v) => v.toJson()).toList();
    }
    if (this.vehicleDetail != null) {
      data['VehicleDetail'] =
          this.vehicleDetail!.map((v) => v.toJson()).toList();
    }
    if (this.incidentDetail != null) {
      data['IncidentDetail'] =
          this.incidentDetail!.map((v) => v.toJson()).toList();
    }
    if (this.detailOfLoss != null) {
      data['DetailOfLoss'] = this.detailOfLoss!.map((v) => v.toJson()).toList();
    }
    if (this.thirdPartyDetail != null) {
      data['ThirdPartyDetail'] =
          this.thirdPartyDetail!.map((v) => v.toJson()).toList();
    }
    if (this.documentDetail != null) {
      data['DocumentDetail'] =
          this.documentDetail!.map((v) => v.toJson()).toList();
    }
    data['Token'] = this.token;
    return data;
  }
}

class InsuredDetail {
  String? contractNo;
  String? policyNo;
  String? insuredName;
  String? insuredAddress;
  String? insuredPhone;
  String? email;
  String? sign;

  InsuredDetail(
      {this.contractNo,
        this.policyNo,
        this.insuredName,
        this.insuredAddress,
        this.insuredPhone,
        this.email,
        this.sign});

  InsuredDetail.fromJson(Map<String, dynamic> json) {
    contractNo = json['ContractNo'];
    policyNo = json['PolicyNo'];
    insuredName = json['InsuredName'];
    insuredAddress = json['InsuredAddress'];
    insuredPhone = json['InsuredPhone'];
    email = json['Email'];
    sign = json['Sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContractNo'] = this.contractNo;
    data['PolicyNo'] = this.policyNo;
    data['InsuredName'] = this.insuredName;
    data['InsuredAddress'] = this.insuredAddress;
    data['InsuredPhone'] = this.insuredPhone;
    data['Email'] = this.email;
    data['Sign'] = this.sign;
    return data;
  }
}

class ClaimantDetail {
  String? claimantName;
  String? claimantAddress;
  String? claimantPhone;
  String? claimantEmail;
  String? claimantRelationship;

  ClaimantDetail(
      {this.claimantName,
        this.claimantAddress,
        this.claimantPhone,
        this.claimantEmail,
        this.claimantRelationship});

  ClaimantDetail.fromJson(Map<String, dynamic> json) {
    claimantName = json['ClaimantName'];
    claimantAddress = json['ClaimantAddress'];
    claimantPhone = json['ClaimantPhone'];
    claimantEmail = json['ClaimantEmail'];
    claimantRelationship = json['ClaimantRelationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClaimantName'] = this.claimantName;
    data['ClaimantAddress'] = this.claimantAddress;
    data['ClaimantPhone'] = this.claimantPhone;
    data['ClaimantEmail'] = this.claimantEmail;
    data['ClaimantRelationship'] = this.claimantRelationship;
    return data;
  }
}

class VehicleDetail {
  String? brandType;
  int? manufactureYear;
  String? chassisNo;
  String? machineNo;
  String? plateNo;

  VehicleDetail(
      {this.brandType,
        this.manufactureYear,
        this.chassisNo,
        this.machineNo,
        this.plateNo});

  VehicleDetail.fromJson(Map<String, dynamic> json) {
    brandType = json['BrandType'];
    manufactureYear = json['ManufactureYear'];
    chassisNo = json['ChassisNo'];
    machineNo = json['MachineNo'];
    plateNo = json['PlateNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BrandType'] = this.brandType;
    data['ManufactureYear'] = this.manufactureYear;
    data['ChassisNo'] = this.chassisNo;
    data['MachineNo'] = this.machineNo;
    data['PlateNo'] = this.plateNo;
    return data;
  }
}

class IncidentDetail {
  String? dateOfIncident;
  String? incidentLocation;
  int? speed;
  String? driverName;
  String? driverAddress;
  String? sIMType;
  String? sIMNo;
  String? sIMExp;
  bool? isDriverOfInsured;
  bool? isDrivingAsInsuredOrder;
  String? vehicleUsageOnIncident;
  bool? isReportedToPolice;
  String? policeLocation;
  String? chronology;

  IncidentDetail(
      {this.dateOfIncident,
        this.incidentLocation,
        this.speed,
        this.driverName,
        this.driverAddress,
        this.sIMType,
        this.sIMNo,
        this.sIMExp,
        this.isDriverOfInsured,
        this.isDrivingAsInsuredOrder,
        this.vehicleUsageOnIncident,
        this.isReportedToPolice,
        this.policeLocation,
        this.chronology});

  IncidentDetail.fromJson(Map<String, dynamic> json) {
    dateOfIncident = json['DateOfIncident'];
    incidentLocation = json['IncidentLocation'];
    speed = json['Speed'];
    driverName = json['DriverName'];
    driverAddress = json['DriverAddress'];
    sIMType = json['SIMType'];
    sIMNo = json['SIMNo'];
    sIMExp = json['SIMExp'];
    isDriverOfInsured = json['IsDriverOfInsured'];
    isDrivingAsInsuredOrder = json['IsDrivingAsInsuredOrder'];
    vehicleUsageOnIncident = json['VehicleUsageOnIncident'];
    isReportedToPolice = json['IsReportedToPolice'];
    policeLocation = json['PoliceLocation'];
    chronology = json['Chronology'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DateOfIncident'] = this.dateOfIncident;
    data['IncidentLocation'] = this.incidentLocation;
    data['Speed'] = this.speed;
    data['DriverName'] = this.driverName;
    data['DriverAddress'] = this.driverAddress;
    data['SIMType'] = this.sIMType;
    data['SIMNo'] = this.sIMNo;
    data['SIMExp'] = this.sIMExp;
    data['IsDriverOfInsured'] = this.isDriverOfInsured;
    data['IsDrivingAsInsuredOrder'] = this.isDrivingAsInsuredOrder;
    data['VehicleUsageOnIncident'] = this.vehicleUsageOnIncident;
    data['IsReportedToPolice'] = this.isReportedToPolice;
    data['PoliceLocation'] = this.policeLocation;
    data['Chronology'] = this.chronology;
    return data;
  }
}

class DetailOfLoss {
  String? vehicleLocation;
  String? vehicleDamageDescription;
  int? estimatedLoss;
  bool? isAnotherPersonInvolved;
  String? involvedPersonName;
  String? involvedPersonAddress;
  String? involvedPersonInsurance;

  DetailOfLoss(
      {this.vehicleLocation,
        this.vehicleDamageDescription,
        this.estimatedLoss,
        this.isAnotherPersonInvolved,
        this.involvedPersonName,
        this.involvedPersonAddress,
        this.involvedPersonInsurance});

  DetailOfLoss.fromJson(Map<String, dynamic> json) {
    vehicleLocation = json['VehicleLocation'];
    vehicleDamageDescription = json['VehicleDamageDescription'];
    estimatedLoss = json['EstimatedLoss'];
    isAnotherPersonInvolved = json['IsAnotherPersonInvolved'];
    involvedPersonName = json['InvolvedPersonName'];
    involvedPersonAddress = json['InvolvedPersonAddress'];
    involvedPersonInsurance = json['InvolvedPersonInsurance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VehicleLocation'] = this.vehicleLocation;
    data['VehicleDamageDescription'] = this.vehicleDamageDescription;
    data['EstimatedLoss'] = this.estimatedLoss;
    data['IsAnotherPersonInvolved'] = this.isAnotherPersonInvolved;
    data['InvolvedPersonName'] = this.involvedPersonName;
    data['InvolvedPersonAddress'] = this.involvedPersonAddress;
    data['InvolvedPersonInsurance'] = this.involvedPersonInsurance;
    return data;
  }
}

class ThirdPartyDetail {
  String? thirdPartyName;
  String? thirdPartyAddress;
  String? thirdPartyPhone;
  String? thirdPartyLoss;
  bool? thirdPartyInsurance;
  String? thirdPartyInsuranceName;

  ThirdPartyDetail(
      {this.thirdPartyName,
        this.thirdPartyAddress,
        this.thirdPartyPhone,
        this.thirdPartyLoss,
        this.thirdPartyInsurance,
        this.thirdPartyInsuranceName});

  ThirdPartyDetail.fromJson(Map<String, dynamic> json) {
    thirdPartyName = json['ThirdPartyName'];
    thirdPartyAddress = json['ThirdPartyAddress'];
    thirdPartyPhone = json['ThirdPartyPhone'];
    thirdPartyLoss = json['ThirdPartyLoss'];
    thirdPartyInsurance = json['ThirdPartyInsurance'];
    thirdPartyInsuranceName = json['ThirdPartyInsuranceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ThirdPartyName'] = this.thirdPartyName;
    data['ThirdPartyAddress'] = this.thirdPartyAddress;
    data['ThirdPartyPhone'] = this.thirdPartyPhone;
    data['ThirdPartyLoss'] = this.thirdPartyLoss;
    data['ThirdPartyInsurance'] = this.thirdPartyInsurance;
    data['ThirdPartyInsuranceName'] = this.thirdPartyInsuranceName;
    return data;
  }
}

class DocumentDetail {
  String? sTPL;

  DocumentDetail({this.sTPL});

  DocumentDetail.fromJson(Map<String, dynamic> json) {
    sTPL = json['STPL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STPL'] = this.sTPL;
    return data;
  }
}
