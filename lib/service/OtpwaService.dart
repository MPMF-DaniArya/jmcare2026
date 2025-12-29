import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'BaseService.dart';

class OtpwaService extends BaseService{
  static OtpwaService instance = OtpwaService();
  Future<BaseRespon?> sendOTP(String nomorHP, String otp) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postString(Endpoint.TAG_RESET_PASSWORD_OTP_BY_WA, body: {
        "tipe_transaksi":"Reset password Jmcare",
        "template_id":"6673adef0c88910a943db837",
        "handphone": nomorHP,
        "createby":"jmcare",
        "parameter1":otp
      });
    }catch(e){
      return BaseError();
    }
  }
}
