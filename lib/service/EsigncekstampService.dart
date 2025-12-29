import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/EsigncekstampRespon.dart';
import 'package:jmcare/model/api/EsigndownloadRespon.dart';
import 'package:jmcare/model/api/EsignsignRespon.dart';
import 'package:jmcare/model/api/EsignstatussignRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class EsigncekstampService extends BaseService {
  static EsigncekstampService instance = EsigncekstampService();

  Future<EsigncekstampRespon?> cekStamp(String refNumber) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_CHECK_STAMPING, body: {
        "audit": {"callerId": "User${Endpoint.TAG_ESIGN_TENANT_CODE}"},
        "refNumber": refNumber
      });
    } catch (e) {
      return EsigncekstampError();
    }
  }
}
