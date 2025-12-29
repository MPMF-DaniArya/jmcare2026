import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class EsignsentotpService extends BaseService {
  static EsignsentotpService instance = EsignsentotpService();

  Future<EsignSentotpRespon?> getOTP(String hp, String email, String refNumber) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_SENT_OTP_SIGNING, body: {
        "audit": {"callerId": "User${Endpoint.TAG_ESIGN_TENANT_CODE}"},
        "phoneNo": hp,
        "email": email,
        "refNumber": refNumber
      });
    } catch (e) {
      return EsignsentotpError();
    }
  }
}
