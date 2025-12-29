class VersiModel {
  String? appName;
  String? packageName;
  String? appVersion;
  String? buildNumber;
  String? buildSignature;
  String? installerStore;

  VersiModel(
      {this.appName,
        this.packageName,
        this.appVersion,
        this.buildNumber,
        this.buildSignature,
        this.installerStore});

  VersiModel.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    packageName = json['packageName'];
    appVersion = json['appVersion'];
    buildNumber = json['buildNumber'];
    buildSignature = json['buildSignature'];
    installerStore = json['installerStore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['packageName'] = this.packageName;
    data['appVersion'] = this.appVersion;
    data['buildNumber'] = this.buildNumber;
    data['buildSignature'] = this.buildSignature;
    data['installerStore'] = this.installerStore;
    return data;
  }
}

