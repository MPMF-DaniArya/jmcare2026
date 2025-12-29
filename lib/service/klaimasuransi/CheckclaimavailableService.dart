import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class CheckclaimavailableService extends BaseService {
  static CheckclaimavailableService instance = CheckclaimavailableService();
  Future<BaseRespon?> checkClaimAvailable(String agreement_no) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_KLAIM_ASURANSI_CHECK_CLAIM_AVAILABLE, body: {
        "agreement_no": agreement_no
      });
    }catch(e){
      return BaseError();
    }
  }
}