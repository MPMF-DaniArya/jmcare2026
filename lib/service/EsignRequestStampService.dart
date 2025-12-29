import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/model/api/EsignRequestStampRespon.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/EsigndownloadRespon.dart';
import 'package:jmcare/model/api/EsignsignRespon.dart';
import 'package:jmcare/model/api/EsignstatussignRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class EsignRequestStampService extends BaseService {
  static EsignRequestStampService instance = EsignRequestStampService();

  Future<EsignRequestStampRespon?> requestStamp(String refNumber) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_REQUEST_STAMPING, body: {
        "audit": {"callerId": "User${Endpoint.TAG_ESIGN_TENANT_CODE}"},
        "refNumber": refNumber
      });
    } catch (e) {
      return EsignRequestStampError();
    }
  }
}
