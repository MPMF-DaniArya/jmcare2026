
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class OnesignalUpdateIdService extends BaseService {
  static OnesignalUpdateIdService instance = OnesignalUpdateIdService();
  Future<BaseRespon?> updateID (String login_user_id, String one_signal_id) async {
    try{
      return postJSON(Endpoint.TAG_ONESIGNAL_UPDATEID, body: {
        "login_user_id":login_user_id,
        "new_onesignal_id":one_signal_id
      });
    }catch(e){
      return BaseError();
    }
  }
}
