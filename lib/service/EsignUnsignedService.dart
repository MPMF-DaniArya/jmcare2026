import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class EsignunsignedService extends BaseService {
  static EsignunsignedService instance = EsignunsignedService();

  Future<EsignunsignedRespon?> getUnsigned(String email) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_UNSIGNED_DOC, body: {
        "audit": {"callerId": "User${Endpoint.TAG_ESIGN_TENANT_CODE}"},
        "email": email
      });
    } catch (e) {
      return EsignunsignedError();
    }
  }
}
