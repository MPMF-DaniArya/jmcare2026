import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';

class EContractdownloadService extends BaseService {

  static EContractdownloadService instance = EContractdownloadService();
  Future<BaseRespon?> downloadDocument(
        String agreement_no
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_DOWNLOAD_ECONTRACT, body: {
        "agreement_no": agreement_no,
      });
    }catch(e){
      return BaseError();
    }
  }
}