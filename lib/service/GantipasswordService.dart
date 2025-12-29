import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';

class GantipasswordService extends BaseService {

  static GantipasswordService instance = GantipasswordService();
  Future<BaseRespon?> gantiPassword(
        int login_user_id,
        String old_password,
        String new_password
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_GANTI_PASSWORD, body: {
        "login_user_id":login_user_id,
        "old_password": old_password,
        "new_password": new_password
      });
    }catch(e){
      return BaseError();
    }
  }
}