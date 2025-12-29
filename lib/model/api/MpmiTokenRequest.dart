class MpmiTokenRequest {
  String? secretKey;

  MpmiTokenRequest({this.secretKey});

  MpmiTokenRequest.fromJson(Map<String, dynamic> json) {
    secretKey = json['SecretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SecretKey'] = this.secretKey;
    return data;
  }
}
