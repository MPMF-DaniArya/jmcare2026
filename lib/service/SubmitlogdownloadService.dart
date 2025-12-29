import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';

class SubmitlogdownloadService extends BaseService {

  static SubmitlogdownloadService instance = SubmitlogdownloadService();
  Future<BaseRespon?> submitLogDownload(
        int login_user_id,
        String agreement_no,
        String jenis_dokumen
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_SUBMIT_LOG_DOWNLOAD, body: {
        "login_user_id" : login_user_id,
        "agreement_no"  : agreement_no,
        "jenis_dokumen" : jenis_dokumen
      });
    }catch(e){
      return BaseError();
    }
  }
}