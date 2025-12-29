import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/CekRegistrasiesignRequest.dart';
import 'package:jmcare/model/api/CekRegistrasiesignRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class CekRegistrasiesignService extends BaseService {
  static CekRegistrasiesignService instance = CekRegistrasiesignService();

  Future<CekRegistrasiesignRespon?> cekRegistrasi(String noKTP) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_CEK_REGISTRASI, body: {
        "audit": {"callerId": "USER@AD-INS.COM"},
        "dataType": "NIK",
        "userData": noKTP
      });
    } catch (e) {
      return CekregistrasiesignError();
    }
  }
}
