import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/NotifRespon.dart';

class OnesignalgetnotifService extends BaseService {
  static OnesignalgetnotifService instance = OnesignalgetnotifService();
  Future<NotifRespon?> getNotif(String login_user_id) async {
    try{
      return getResources(Endpoint.TAG_ONESIGNAL_GETNOTIF, body: {
        "login_user_id":login_user_id
      });
    }catch(e){
      return NotifError();
    }
  }
}
