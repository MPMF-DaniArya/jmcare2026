import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/EsignsignRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class EsignsignService extends BaseService {
  static EsignsignService instance = EsignsignService();

  Future<EsignsignRespon?> sign(List<String> documentId, String email, String password, String otp) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_SIGN, body: {
        "audit": {"callerId": "User${Endpoint.TAG_ESIGN_TENANT_CODE}"},
        "documentId": documentId,
        "email": email,
        "password": password,
        "ipAddress": "192.158.1.38",
        "browserInfo": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36",
        "otp": otp,
        "selfPhoto":""
      });
    } catch (e) {
      return EsignsignError();
    }
  }
}
