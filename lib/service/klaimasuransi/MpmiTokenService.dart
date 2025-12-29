import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/MpmiBaseRespon.dart';

class MpmitokenService extends BaseService {
  static MpmitokenService instance = MpmitokenService();
  Future<MpmiBaseRespon?> getToken() async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postMPMI(Endpoint.TAG_MPMI_GET_TOKEN, body: {
        "SecretKey":Konstan.tag_secret_key_mpmi
      });
    }catch(e){
      return MpmibaseError();
    }
  }
}